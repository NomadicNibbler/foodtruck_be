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
              :display,
              :id,
              :description_short,
              :get_last_know_location_date,
              :recent_data

  def initialize(data)
    @id = nil
    @name = data[:name]
    @lat = add_latitude(data)
    @long = add_longitude(data)
    @distance = 0
    @logo = add_image(data)
    @payment_methods = get_payments(data)
    @website = get_website(data)
    @socials = get_socials(data)
    @phone = get_phone(data)
    @description = get_description(data)
    @description_short = get_description_short(data)
    @display = get_display(data)
    # @get_last_know_location_date = get_last_know_location_date(data)
    @recent_data = recent_data?(data)
  end

  def add_distance(distance)
    @distance = distance
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

  def add_image(data)
    if data[:images] && data[:images][:logo]
      @logo = data[:images][:logo]
    else
      @logo = ''
    end
  end

  def get_payments(data)
    if data[:payment_methods]
      data[:payment_methods]
    else
      ''
    end
  end

  def get_website(data)
    if data[:website]
      data[:website]
    else
      ''
    end
  end

  def get_socials(data)
    socials = Hash.new
    if data[:twitter]
      socials[:twitter] = data[:twitter]
    end
    if data[:facebook]
      socials[:facebook] = data[:facebook]
    end
    if data[:instagram]
      socials[:instagram] = data[:instagram]
    end
    socials
  end

  def get_phone(data)
    if data[:phone]
      data[:phone]
    else
      ''
    end
  end

  def get_display(data)
    if !data[:display].nil?
      @display = data[:display]
    else
      @display = ''
    end
  end

  def get_description(data)
    if !data[:description].nil?
      @description_short = data[:description]
    else
      @description_short = ''
    end
  end

  def get_description_short(data)
    if !data[:description_short].nil?
      @description_short = data[:description_short]
    else
      @description_short = ''
    end
  end

  # def get_last_know_location_date(data)
    # if data[:last] && data[:last][:time]
      # data[:last][:time]
    # else
      # 0
    # end
  # end

  def recent_data?(data)
    if data[:last] && data[:last][:time]
      if (Time.now.to_i - data[:last][:time]) < 2629743
        true
      else
        false
      end
    else
      false
    end
  end
end
