class UserSerializer
  include FastJsonapi::ObjectSerializer

  attribute :username do |user|
    user.username
  end

  attribute :first_name do |user|
    user.first_name
  end

  attribute :last_name do |user|
    user.last_name
  end

  attribute :address do |user|
    user.address
  end

  attribute :city do |user|
    user.city
  end

  attribute :zipcode do |user|
    user.zipcode
  end

end
