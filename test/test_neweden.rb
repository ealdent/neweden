require 'helper'

class TestNeweden < Test::Unit::TestCase
  context "with dummy api key" do
    setup do
      # set up a NewEden object with dummy api values to ensure everything is defined
      @neweden = NewEden.new("000000", "0x0x0x0x0x0x0x0x0x0x0x0x0x0x0")
    end

    context "a character" do
      should "define methods against all character endpoints with standard names" do
        NewEden::CHARACTER_ENDPOINTS.each do |endpoint|
          assert @neweden.respond_to? endpoint.to_s.underscore
        end
      end

      should "define methods against special character endpoints" do
        assert @neweden.respond_to? 'calendar_event_attendees'
        assert @neweden.respond_to? 'upcoming_calendar_events'
      end
    end
    
    context "an account" do
      should "define methods against all account endpoints" do
        assert @neweden.respond_to? 'account_status'
        assert @neweden.respond_to? 'api_key_info'
        assert @neweden.respond_to? 'characters'
      end
    end

    context "a corporation" do
      should "define methods against all corporation endpoints" do
        NewEden::CORPORATION_ENDPOINTS.each do |endpoint|
          assert @neweden.respond_to? "corp_#{endpoint.to_s.underscore}"
        end
      end
    end

    context "general eve" do
      should "define methods against all standard eve endpoints" do
        NewEden::EVE_ENDPOINTS.each do |endpoint|
          assert @neweden.respond_to? "eve_#{endpoint.to_s.underscore}"
        end
      end
      
      should "define methods against all special eve endpoints" do
        assert @neweden.respond_to? 'character_ids'
        assert @neweden.respond_to? 'character_info'
        assert @neweden.respond_to? 'character_names'
      end
    end

    context "maps" do
      should "define methods against all standard map endpoints" do
        NewEden::MAP_ENDPOINTS.each do |endpoint|
          assert @neweden.respond_to? "map_#{endpoint.to_s.underscore}"
        end
      end
    end

    context "server" do
      should "define methods against all server endpoints" do
        assert @neweden.respond_to? 'server_status'
      end
    end

    context "api" do
      should "define methods against all general api endpoints" do
        assert @neweden.respond_to? 'call_list'
      end
    end

    context 'images' do
      should "define methods for getting the url of all image types and sizes" do
        NewEden::IMAGE_ENDPOINTS.each_pair do |endpoint, sizes|
          sizes.each do |size|
            assert @neweden.respond_to? "#{endpoint.to_s.underscore}_image_url_#{size}"
          end
        end
      end
    end
  end

  # context "the live api" do
  #   setup do
  #     # These tests are all meant to be run against the actual API
  #     @config = Psych.load_file(File.join(File.dirname(__FILE__), 'config', 'eve-api.yml'))
  #   end

  #   context "a character" do

  #   end
  # end
end
