class Truck
  attr_reader :lat,
              :long,
              :name,
              :distance,
              :logo,
              :payment_methods,
              :website,
              :socials,
              :phone,
              :description,
              :display

  def initialize(data)
    @name = data[:name]
    @lat = add_latitude(data)
    @long = add_longitude(data)
    @distance = 0
    @logo = add_image(data)
    @payment_methods = nil
    @website = data[:url]
    @socials = get_socials(data)
    @phone = data[:phone]
    @description = data[:description]
    @display = get_display(data)
  end

  def add_distance(distance)
    @distance = distance
  end

  def add_image(data)
    if data[:images] && data[:images][:logo]
      @logo = data[:images][:logo]
    else
      @logo = 'no image available'
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

  def get_socials(data)
  end

  def get_display(data)
  end

end
