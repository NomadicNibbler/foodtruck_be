class MapService

  def self.get_coords(address)
    response = connection.get("/geocoding/v1/address") do |req|
      req.params['key'] = ENV['COORD_KEY']
      req.params['location'] = address
    end
    data = parse(response)

    data[:results][0][:locations][0][:latLng]
  end

  private

  def self.connection
    connection ||= Faraday.new({ url: ENV['COORD_URL'] })
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
