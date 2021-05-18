class TruckLite
  attr_reader :lat,
              :long,
              :name,
              :distance,
              :logo_small

  def initialize(data)
    @name = data[:name]
    @lat = add_latitude(data)
    @long = add_longitude(data)
    @distance = 0
    @logo_small = add_image(data)
  end

  def add_distance(distance)
    @distance = distance
  end

  def add_image(data)
    if data[:images] && data[:images][:logo_small]
      @logo_small = data[:images][:logo_small]
    else
      @logo_small = 'no image available'
    end
  end

  def add_latitude(data)
    if data[:last] && data[:last][:latitude]
      @lat = data[:last][:latitude]
    else
      @lat = 'no last location available'
    end
  end

  def add_longitude(data)
    if data[:last] && data[:last][:longitude]
      @long = data[:last][:longitude]
    else
      @long = 'no last location available'
    end
  end
end
