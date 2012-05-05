module NewEden
  module Character
    CHARACTER_ENDPOINTS = %w{ AccountBalance AssetList CharacterSheet ContactList ContactNotifications Contracts FacWarStats
      IndustryJobs Killlog MailBodies MailingLists MailMessages MarketOrders Medals Notifications Research
      SkillinTraining SkillQueue Standings WalletJournal WalletTransactions
    }

    CHARACTER_ENDPOINTS.each do |endpoint|
      module_eval <<-RUBY
        def #{endpoint.underscore}(character_id)
          character_request("/char/#{endpoint}.xml.aspx", character_id)
        end
      RUBY
    end

    def notification_texts(character_id, *notification_ids)
      request("/char/NotificationTexts.xml.aspx", :post, :characterID => character_id, :IDs => notification_ids.map { |nid| nid.to_s }.join(','))
    end

    def all_notification_texts(character_id)
      n_results = self.notifications(character_id)
      if n_results[:rowset][:row].nil?
        nil
      else
        notification_ids = n_results[:rowset][:row].map { |row| row[:notificationID] }
        notification_texts(character_id, notification_ids)
      end
    end

    def calendar_event_attendees(character_id)
      upcoming_calendar_events(character_id)
      character_request("/char/CalendarEventAttendees.xml.aspx", character_id)
    end

    def upcoming_calendar_events(character_id)
      @upcoming_events ||= {}
      @upcoming_events[character_id.to_s] ||= character_request("/char/UpcomingCalendarEvents.xml.aspx", character_id)
    end

    alias :factional_warfare_stats :fac_war_stats
    alias :kill_log :killlog
    alias :skill_in_training :skillin_training

    private

    def character_request(endpoint, character_id)
      request(endpoint, :post, :characterID => character_id)
    end
  end
end