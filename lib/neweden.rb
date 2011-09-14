require 'typhoeus'
require 'nokogiri'
require 'awesome_print'
require 'active_support/core_ext/hash/conversions'

require File.join(File.dirname(__FILE__), 'neweden', 'errors')
require File.join(File.dirname(__FILE__), 'neweden', 'account')
require File.join(File.dirname(__FILE__), 'neweden', 'api')
require File.join(File.dirname(__FILE__), 'neweden', 'character')
require File.join(File.dirname(__FILE__), 'neweden', 'corporation')
require File.join(File.dirname(__FILE__), 'neweden', 'eve')
require File.join(File.dirname(__FILE__), 'neweden', 'image')
require File.join(File.dirname(__FILE__), 'neweden', 'map')
require File.join(File.dirname(__FILE__), 'neweden', 'server')

class NewEden
  include Account
  include Api
  include Character
  include Corporation
  include Eve
  include Image
  include Map
  include Server

  REQUEST_TIMEOUT = 60000     # 60 seconds
  CACHE_TIMEOUT   = 300       # 5 minutes

  attr_reader :key_id, :vcode, :server, :game_server, :test_server, :hydra

  def initialize(key_id, vcode, use_test = false)
    @key_id         = key_id
    @vcode          = vcode
    @game_server    = "api.eveonline.com".freeze
    @test_server    = "apitest.eveonline.com".freeze
    @server = use_test ? @test_server : @game_server
    @hydra = Typhoeus::Hydra.new
  end

  def request(endpoint, method = :post, params = {})
    xml = handle_response(raw_request(endpoint, method, params))
    if xml
      symbolize_keys(Hash.from_xml((xml/:eveapi/:result).to_s))[:result] rescue raise XMLParsingError, "No result in set"
    else
      raise XMLParsingError, "No XML parsed successfully"
    end
  end

  def raw_request(endpoint, method = :post, params = {})
    url = "https://#{@server}/#{sanitize_endpoint(endpoint)}"
    case method
    when :get
      Typhoeus::Request.get(url, request_params(params))
    when :put
      Typhoeus::Request.put(url, request_params(params))
    when :delete
      Typhoeus::Request.delete(url, request_params(params))
    else
      Typhoeus::Request.post(url, request_params(params))
    end
  end

  def handle_response(response)
    if response.timed_out?
      raise TimeoutError, "Response timed out."
    elsif response.code == 0
      raise NoResponseError, "No response received."
    elsif response.code == 404
      raise NotFoundError, "API endpoint not found."
    elsif !response.success?
      raise UnsuccessfulResponseError, "Received HTTP response: #{response.code.to_s}"
    end

    xml = Nokogiri::XML.parse(response.body)

    unless (xml/:eveapi/:error).empty?
      if (xml/:eveapi/:error).attribute('code').value == '203'
        raise AuthenticationError, "Invalid key id or vcode."
      else
        raise ApiError, (xml/:eveapi/:error).children.map { |e| e.to_s.gsub(/\.$/, '') }.join(", ")
      end
    end

    xml
  end

  def use_game_server
    @server = @game_server
  end

  def use_test_server
    @server = @test_server
  end

  def request_url
    "https://#{@server}/#{sanitize_endpoint(endpoint)}"
  end

  def request_params(params = {})
    {
      :headers => { :Accept => "application/xml" },
      :timeout => REQUEST_TIMEOUT,
      :cache_timeout => CACHE_TIMEOUT,
      :params => params.merge({ :keyID => @key_id, :vCode => @vcode })
    }
  end

  private

  def sanitize_endpoint(endpoint)
    endpoint.strip.gsub(/^\/+/, '')
  end

  def symbolize_keys(myhash)
    myhash.symbolize_keys!
    myhash.keys.each do |key|
      if myhash[key].kind_of?(Hash)
        symbolize_keys(myhash[key])
      elsif myhash[key].kind_of?(Array)
        myhash[key].each do |element|
          symbolize_keys(element) if element.kind_of?(Hash)
        end
      elsif myhash[key].is_a?(String)
        if myhash[key].strip =~ /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/
          myhash[key] = DateTime.parse(myhash[key]).to_time
        elsif myhash[key].strip =~ /^\d+$/
          myhash[key] = myhash[key].to_i
        elsif myhash[key].strip =~ /^\d+\.\d+$/
          myhash[key] = myhash[key].to_f
        end
      end
    end

    myhash
  end
end
