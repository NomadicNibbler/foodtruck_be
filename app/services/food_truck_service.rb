class FoodTruckService
  def self.get_regions
    connection.get("/1.1/regions")
  end

  def self.get_schedules_by_city(region_identifier)
    connection.get("/1.1/schedule/#{region_identifier}")
  end

  # def self.get_truck_info(truck_identifier)
  #   connection.get("/1.1/vendors/#{vendor_identifier}")
  # end


  private

  def self.connection
    conn = Faraday.new({url: "http://data.streetfoodapp.com"}) do |f|
      f.use FaradayMiddleware::FollowRedirects, limit: 5
      f.adapter Faraday.default_adapter
    end
  end
end
