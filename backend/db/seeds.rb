# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Enemy.find_or_create_by(name: 'スライム').update(
  weakness_weather: 'thunderstorm',
  max_hp:           30,
  attack_power:     8
)
Enemy.find_or_create_by(name: 'ゴーレム').update(
  weakness_weather: 'rain',
  max_hp:           60,
  attack_power:     15
)
Enemy.find_or_create_by(name: 'ドラゴン').update(
  weakness_weather: 'wind',
  max_hp:           100,
  attack_power:     25
)
