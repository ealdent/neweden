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

  # comment out these next two contexts if you do not want to test against the live api
  context "with character credentials" do
    setup do
      # These tests are all meant to be run against the actual API
      @config = Psych.load_file(File.join(File.dirname(__FILE__), 'config', 'eve-api.yml'))[:character]
      @neweden = NewEden.new(@config[:key_id], @config[:vcode])
    end

    should "have credentials present" do
      assert !@config.blank?
    end

    context "a character" do
      NewEden::CHARACTER_ENDPOINTS.each do |endpoint|
        should "respond to #{endpoint} endpoint" do
          begin
            result = @neweden.send(endpoint.to_s.underscore, @config[:character_id])
            assert result.is_a?(Hash)
            assert !result.blank?
          rescue NewEden::NotInvolvedInFactionalWarfare
            assert true
          end
        end
      end

      should "define methods against special character endpoints" do
        assert @neweden.respond_to? 'calendar_event_attendees'
        assert @neweden.respond_to? 'upcoming_calendar_events'
      end
    end
  end

  context "with corporate credentials" do
    setup do
      @config = Psych.load_file(File.join(File.dirname(__FILE__), 'config', 'eve-api.yml'))[:corporation]
    end

    should "have credentials present" do
      assert !@config.blank?
    end
  end
end
