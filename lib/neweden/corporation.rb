module NewEden
  module Corporation
    CORPORATION_ENDPOINTS = %w{ AccountBalance AssetList ContactList ContainerLog Contracts CorporationSheet FacWarStats
      IndustryJobs Killlog MarketOrders Medals MemberMedals MemberSecurity MemberSecurityLog MemberTracking OutpostList
      OutpostServiceDetail Shareholders Standings StarbaseDetail StarbaseList Titles WalletJournal WalletTransactions
    }

    CORPORATION_ENDPOINTS.each do |endpoint|
      module_eval <<-RUBY
        def corp_#{endpoint.underscore}(character_id)
          corportaion_request("/corp/#{endpoint}.xml.aspx", character_id)
        end
      RUBY
    end

    alias :corp_account_balances :corp_account_balance
    alias :corp_factional_warfare_stats :corp_fac_war_stats
    alias :corp_kill_log :corp_killlog

    private

    def corportaion_request(endpoint, character_id)
      request(endpoint, :post, :characterID => character_id)
    end
  end
end