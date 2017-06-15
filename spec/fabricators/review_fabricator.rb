Fabricator(:review) do
  rating { (1..5).to_a.sample }
  description { Faker::Lorem.paragraphs(2) }
  business { Fabricate(:business) }
  user { Fabricate(:user) }
end