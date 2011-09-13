module Map
  MAP_ENDPOINTS = %w{ FacWarSystems Jumps Kills Sovereignty }

  MAP_ENDPOINTS.each do |endpoint|
    module_eval <<-RUBY
      def map_#{endpoint.to_s.underscore}
        request("/map/#{endpoint}.xml.aspx")
      end
    RUBY
  end

  alias :map_factional_warfare_systems :map_fac_war_systems
  alias :factional_warfare_systems :map_fac_war_systems
end
