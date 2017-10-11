ENV['RAILS_ENV'] = "development" # Set to your desired Rails environment name
require "/Users/ali/Desktop/CodingDojo.nosync/Projects/flight_price_notify/railsNotiflight/config/environment.rb"

flights = Flight.all
flights.each do |flight|
    #send email to each flight
end