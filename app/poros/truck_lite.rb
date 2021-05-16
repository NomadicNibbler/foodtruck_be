class TruckLite
  attr_reader :id,
              :lat,
              :long,
              :name,
              :distance,
              :logo_small

  def initialize(data)
    @id = data[:id]
    @lat = data[:lat]
    @long = data[:long]
    @name = data[:name]
    @distance = 0
    @logo_small = data[:logo_small]
  end

  def add_distance(distance)
    @distance = distance
  end 
end
