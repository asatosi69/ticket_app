# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', name: '0') if Rails.env.development?
User.create!(email: 'puente.japan@gmail.com', password: 'orangeseed69', password_confirmation: 'orangeseed69', name: '1') if Rails.env.development?
User.create!(email: 'puente.japan2@gmail.com', password: 'orangeseed69', password_confirmation: 'orangeseed69', name: '2') if Rails.env.development?
User.create!(email: 'puente.japan3@gmail.com', password: 'orangeseed69', password_confirmation: 'orangeseed69', name: '3') if Rails.env.development?
User.create!(email: 'puente.japan4@gmail.com', password: 'orangeseed69', password_confirmation: 'orangeseed69', name: '4') if Rails.env.development?
User.create!(email: 'puente.japan5@gmail.com', password: 'orangeseed69', password_confirmation: 'orangeseed69', name: '5') if Rails.env.development?
