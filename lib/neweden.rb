require 'typhoeus'
require 'nokogiri'

class NewEden
  attr_reader :key_id, :vcode, :server, :game_server, :test_server

  def initialize(key_id, vcode, use_test = false)
    @key_id         = key_id
    @vcode          = vcode
    @game_server    = "api.eveonline.com".freeze
    @test_server    = "apitest.eveonline.com".freeze
    @server = use_test ? @test_server : @game_server

    @hydra = Typhoeus::Hydra.new
    @hydra.run
  end

  def test_request(end_point, params = {})
    req = Typhoeus::Request.new("https://#{@server}/#{end_point}",
                                :method => :post,
                                :headers => "Accept: application/xml",
                                :timeout => 500,          # 0.5 seconds
                                :cache_timeout => 300,    # 5 minutes
                                :params => params
                               )

    @hydra.queue(req)
    @req
  end
end
