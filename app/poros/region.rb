class Region
  attr_reader :name,
              :long,
              :lat,
              :country
  def initialize(data)
    @name = data[:name]
    @lat = data[:latitude]
    @long = data[:longitude]
    @country = data[:country]
    @distance = 0
  end
end
