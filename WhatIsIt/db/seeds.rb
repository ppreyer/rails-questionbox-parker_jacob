# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
t.string "title"
    t.text "content"
User.create(username: "ppreyer", password: "password")

20.times do 
  Question.create(
    title: Faker::Vehicle.make_and_model,
    content: Faker::Vehicle.color,
    hop: Faker::Beer.hop,
    user_id: 1
  )
end

100.times do 
  Note.create(
    content: Faker::Beer.style,
    beer_id: Faker::Number.between(1, 100)
  )
end