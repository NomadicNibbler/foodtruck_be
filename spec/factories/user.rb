FactoryBot.define do
  FactoryBot.define do
    factory :user do
      username { Faker::Beer.name }
      first_name { Faker::Name.first_name }
      last_name { Faker::Name.last_name }
      address { Faker::Address.street_address }
      city { Faker::Address.city }
      zipcode { Faker::Address.zip }
    end
  end
end
