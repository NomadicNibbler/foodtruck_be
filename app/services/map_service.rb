class MapService

  def self.get_coords(address)
    res = coordinate_connection.get("/geocoding/v1/address") do |req|
      req.params['key'] = ENV['COORD_KEY']
      req.params['location'] = address
    end
    data = JSON.parse(res.body, symbolize_names: true)
    out = data[:results][0][:locations][0][:latLng]
    redis.set coords, out
    redis.save
    return out
  end

  def self.coordinate_connection
    coordinate_connection ||= Faraday.new({
      url: ENV['COORD_URL']
    })
  end
end
