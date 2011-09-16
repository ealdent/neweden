require 'helper'

class TestNeweden < Test::Unit::TestCase
  context "without credentials" do
    setup do
      # set up a NewEden object with nil api values to ensure everything is defined
      @neweden = NewEden.new(nil, nil)
    end

    context "a character" do
      NewEden::CHARACTER_ENDPOINTS.each do |endpoint|
        should "define method for #{endpoint} character endpoint" do
          assert @neweden.respond_to? endpoint.to_s.underscore
        end
      end

      should "define method for calendar event attendees" do
        assert @neweden.respond_to? 'calendar_event_attendees'
      end

      should "define method upcoming calendar events" do
        assert @neweden.respond_to? 'upcoming_calendar_events'
      end
    end
    
    context "an account" do
      should "define method for account status" do
        assert @neweden.respond_to? 'account_status'
      end
      
      should "define method for api key info" do
        assert @neweden.respond_to? 'api_key_info'
      end

      should "define method for list of characters on account" do
        assert @neweden.respond_to? 'characters'
      end
    end

    context "a corporation" do
      NewEden::CORPORATION_ENDPOINTS.each do |endpoint|
        should "define method for #{endpoint} corporation endpoint" do
          assert @neweden.respond_to? "corp_#{endpoint.to_s.underscore}"
        end
      end
    end

    context "general eve" do
      NewEden::EVE_ENDPOINTS.each do |endpoint|
        should "define method for #{endpoint} eve endpoint" do
          assert @neweden.respond_to? "eve_#{endpoint.to_s.underscore}"
        end
      end
      
      should "define method for getting a list of character ids" do
        assert @neweden.respond_to? 'character_ids'
      end

      should "define method for getting basic character info" do
        assert @neweden.respond_to? 'character_info'
      end
      
      should "define method for getting character names from ids" do
        assert @neweden.respond_to? 'character_names'
      end
    end

    context "maps" do
      NewEden::MAP_ENDPOINTS.each do |endpoint|
        should "define method for #{endpoint} map endpoint" do
          assert @neweden.respond_to? "map_#{endpoint.to_s.underscore}"
        end
      end
    end

    context "server" do
      should "define methods for getting server status" do
        assert @neweden.respond_to? 'server_status'
      end
    end

    context "api" do
      should "define method for getting call list" do
        assert @neweden.respond_to? 'call_list'
      end
    end

    context 'images' do
      NewEden::IMAGE_ENDPOINTS.each_pair do |endpoint, sizes|
        sizes.each do |size|
          should "define methods for getting the url for #{endpoint} of size #{size}" do
            assert @neweden.respond_to? "#{endpoint.to_s.underscore}_image_url_#{size}"
          end
        end
      end
    end
  end
end
