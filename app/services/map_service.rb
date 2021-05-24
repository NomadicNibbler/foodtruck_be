class MapService

  def self.get_coords(address)
    res = coordinate_connection.get("/geocoding/v1/address") do |req|
      req.params['key'] = ENV['COORD_KEY']
      req.params['location'] = address
    end
    data = JSON.parse(res.body, symbolize_names: true)

    if data[:info][:statuscode] == 400 || data[:results][0][:locations][0][:latLng] == {:lat=>39.390897, :lng=>-99.066067}
      return "location not found"
    else
      out = data[:results][0][:locations][0][:latLng]
      redis = Redis.current
      redis.set("address: #{address}", out)
      return out
    end
  end

  def self.coordinate_connection
    coordinate_connection ||= Faraday.new({
      url: ENV['COORD_URL']
    })
  end
end
