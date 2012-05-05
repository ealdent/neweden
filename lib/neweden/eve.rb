module NewEden
  module Eve
    EVE_ENDPOINTS = %w{ AllianceList CertificateTree ConquerableStationList ErrorList FacWarStats FacWarTopStats RefTypes SkillTree }

    EVE_ENDPOINTS.each do |endpoint|
      module_eval <<-RUBY
        def eve_#{endpoint.underscore}
          request("/eve/#{endpoint}.xml.aspx")
        end
      RUBY
    end

    def character_ids(*names)
      request("/eve/CharacterID.xml.aspx", :post, :names => names.join(","))
    end
    alias :character_id :character_ids

    def character_info(character_id)
      request("/eve/CharacterInfo.xml.aspx", :post, :characterID => character_id)
    end

    def character_names(*ids)
      request("/eve/CharacterName.xml.aspx", :post, :ids => ids.join(","))
    end
    alias :character_name :character_names
  end
end