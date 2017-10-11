# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

records = JSON.parse(File.read('/Users/ali/Desktop/CodingDojo.nosync/Projects/flight_price_notify/railsNotiflight/db/airports.json'))

records.each do |record|
    Airport.create(iata: record['iata'], name: record['name'])
end