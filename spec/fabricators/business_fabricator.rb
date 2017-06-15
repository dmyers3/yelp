Fabricator(:business) do
  street_address_1 { Faker::Address.street_address }
  street_address_2 { Faker::Address.secondary_address }
  city { Faker::Address.city }
  state { Faker::Address.state_abbr }
  zip { Faker::Address.zip }
  phone_number { Faker::PhoneNumber.phone_number }
  name { Faker::Company.name }
end