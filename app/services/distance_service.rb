class DistanceService

  def self.get_distance(start, destination)
    response = connection.get("/maps/api/distancematrix/json") do |f|
      f.params["key"] = ENV['GOOGLE_MAPS_API_KEY']
      f.params['origins'] = start
      f.params['destinations'] = destination
      f.params['units'] = 'imperial'
    end
    # unpack and check for invalid query, currently returning a high number to not make invalid region nearest
    data = parse(response)

    if data[:rows].first[:elements].first[:status] == 'ZERO_RESULTS'
      return 100000
    else
      data[:rows].first[:elements].first[:distance][:text].to_f
    end
  end

  private

  def self.connection
    connection = Faraday.new({ url: "https://maps.googleapis.com" })
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
