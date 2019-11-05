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

u = User.create(first_name: Faker::Name.name, last_name: Faker::Name.last_name, password: "okokok", description: Faker::Movie.quote, email: "dexterthp@yopmail.com")

10.times do |index|
  e = Event.create(start_date: Date.today + 1, duration: 10 ,title: "Event-#{index+1}", description: "lorem ipsum"*3, price: Faker::Number.between(from: 1, to: 1000), location: Faker::Nation.capital_city, admin_id: u.id)  
end