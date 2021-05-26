class User < ApplicationRecord
  validates :username, presence: true
  validates :username, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :zipcode, presence: true

  def latitude
    coords = MapService.get_coords("#{address}, #{city}, #{zipcode}")
    if coords == 'location not found'
      return 'invalid location'
    else
      coords[:lat]
    end
  end

  def longitude
    coords = MapService.get_coords("#{address}, #{city}, #{zipcode}")
    if coords == 'location not found'
      return 'invalid location'
    else
      coords[:lng]
    end
  end
end
