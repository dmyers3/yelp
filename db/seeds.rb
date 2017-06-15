# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Business.create([{street_address_1: "123 Main St.", city: "Pittsburgh", state: "PA", zip: "15102", phone_number: "412-833-5555", name: "Sunny's Ice Cream"},
{street_address_1: "888 Basssett Dr.", city: "Raleigh", state: "NC", zip: "27511", phone_number: "919-555-9876", name: "Big Ed's Diner"}])

User.create([{first_name: "Dan", last_name: "Myers", email: "dan@example.com", password: "password"},
{first_name: "Katie", last_name: "Myers", email: "katie@example.com", password: "password"}])

Review.create([{rating: 5, description: "Awesome place!", user_id: 1, business_id: 1},
{rating: 3, description: "So-so experience.", user_id: 1, business_id: 2},
{rating: 4, description: "Pretty solid.", user_id: 2, business_id: 1},
{rating: 1, description: "Horrible!", user_id: 2, business_id: 2}])


