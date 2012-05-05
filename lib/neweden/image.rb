module NewEden
  module Image
    IMAGE_ENDPOINTS = {
      :Character => [30, 32, 64, 128, 200, 256, 512, 1024],
      :Corporation => [30, 32, 64, 128, 256],
      :Alliance => [30, 32, 64, 128],
      :InventoryType => [32, 64],
      :Render => [32, 64, 128, 256, 512]
    }
    IMAGE_ENDPOINTS.each_pair do |endpoint, sizes|
      sizes.each do |size|
        module_eval <<-RUBY
          def #{endpoint.to_s.underscore}_image_url_#{size}(relevant_id, extension = :png)
            image_url(#{endpoint}, relevant_id, #{size}, extension)
          end
        RUBY
      end
    end

    private

    def image_url(type, relevant_id, size, extension = :png)
      "http://image.eveonline.com/#{type}/#{relevant_id}_#{size}.#{extension.to_s}"
    end
  end
end