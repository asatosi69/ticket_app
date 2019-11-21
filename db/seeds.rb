# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#   coding: utf-8

Color.destroy_all
Color.create!(id: 1, color_code: '#FF0000', color_name: '赤')
Color.create!(id: 2, color_code: '#00FF00', color_name: '黄緑')
Color.create!(id: 3, color_code: '#0000FF', color_name: '青')
Color.create!(id: 4, color_code: '#FFFF00', color_name: '黄')
Color.create!(id: 5, color_code: '#00FFFF', color_name: '水色')
Color.create!(id: 6, color_code: '#FF00FF', color_name: 'ピンク')
Color.create!(id: 7, color_code: '#008000', color_name: '緑')
Color.create!(id: 8, color_code: '#000080', color_name: '群青')
Color.create!(id: 9, color_code: '#808000', color_name: 'オリーブ')
Color.create!(id: 10, color_code: '#800080', color_name: '紫')
Color.create!(id: 11, color_code: '#800000', color_name: '栗色')

[
  { nickname: '当日', name: Rails.application.config.default_payment_method_name, discount_rate: 0 },
  { nickname: '代済', name: '代済み', discount_rate: 0 },
  { nickname: '招待', name: '招待', discount_rate: 100 }
].each.with_index(1) do |hash, i|
  PaymentMethod.find_by(id: i)&.destroy
  PaymentMethod.create!(id: i, name: hash[:name], discount_rate: hash[:discount_rate])
end
