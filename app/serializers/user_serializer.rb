class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :username, :first_name, :last_name, :address, :city, :zipcode, :lat, :long
  # attribute :username do |user|
  #   user.username
  # end
  #
  # attribute :first_name do |user|
  #   user.first_name
  # end
  #
  # attribute :last_name do |user|
  #   user.last_name
  # end
  #
  # attribute :address do |user|
  #   user.address
  # end
  #
  attribute :lat do |user|
    user.latitude
  end

  attribute :long do |user|
    user.longitude
  end

end
