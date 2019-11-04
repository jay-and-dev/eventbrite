require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Event.destroy_all
Attendance.destroy_all


1.times do |index|
  u = User.create(first_name: Faker::Name.name, last_name: Faker::Name.last_name, description: Faker::Movie.quote, email: "azoulco" + index.to_s + "@yopmail.com")
  e = Event.create(start_date: Date.today + 1, duration: 10 ,title: "Faker::Name.initials(number: 10)", description: "Faker::Name.initials(number: 30)", price: Faker::Number.between(from: 1, to: 1000), location: Faker::Nation.capital_city, admin_id: u.id)
  a = Attendance.create(user_id: u.id, event_id: e.id)
end