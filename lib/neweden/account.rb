module NewEden
  module Account
    def account_status
      request('/account/AccountStatus.xml.aspx')
    end

    def api_key_info
      request('/account/APIKeyInfo.xml.aspx')
    end

    def characters
      request('/account/Characters.xml.aspx')
    end
  end
end