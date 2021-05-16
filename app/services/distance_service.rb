class DistanceService

  def self.get_distance(start, destination)
    response = connection("/maps/api/distancematrix/json") do |f|
      f.params["key"] = ENV['GOOGLE_MAPS_API_KEY']
      f.params['origins'] = start
      f.params['destinations'] = destination
      f.params['units'] = 'imperial'
      f.params['ambiguities'] = 'ignore'
      f.params['routeType'] = 'fastest'
      f.params['unit'] = 'm'
    end
    parse(response)
  end

  private

  def self.connection
    connection ||= Faraday.new({ url: "http://maps.googleapis.com" })
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
