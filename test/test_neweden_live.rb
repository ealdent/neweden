require 'helper'

class TestNewedenLive < Test::Unit::TestCase
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
      endpoints_to_check = NewEden::CHARACTER_ENDPOINTS + ['CalendarEventAttendees', 'UpcomingCalendarEvents']
      endpoints_to_check.each do |endpoint|
        next if ['NotificationTexts', 'MailBodies'].include?(endpoint)
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

      should "respond to NotificationTexts endpoint" do
        result = @neweden.all_notification_texts(@config[:character_id])
        if result.nil?
          assert true
        else
          assert result.is_a?(Hash)
          assert !result.blank?
        end
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
