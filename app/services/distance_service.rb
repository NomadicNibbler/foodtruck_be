class DistanceService

  def self.get_distance(start, destination)
    response = connection.get("/maps/api/distancematrix/json") do |f|
      f.params["key"] = ENV['GOOGLE_MAPS_API_KEY']
      f.params['origins'] = start
      f.params['destinations'] = destination
      f.params['units'] = 'imperial'
    end
    data = parse(response)
  end

  private

  def self.connection
    connection = Faraday.new(url: "https://maps.googleapis.com", :ssl => {:verify => false} ) do |f|
      f.use FaradayMiddleware::FollowRedirects, limit: 5
      f.adapter Faraday.default_adapter
    end
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
