class Region
  attr_reader :name,
              :long,
              :lat,
              :country,
              :distance

  def initialize(data)
    @name = data[:name]
    @lat = data[:latitude]
    @long = data[:longitude]
    @country = data[:country]
    @distance = 0
  end

  def add_distance(distance)
    @distance = distance
  end
end
