ENV['RAILS_ENV'] = "development" # Set to your desired Rails environment name
require "/Users/ali/Desktop/CodingDojo.nosync/Projects/flight_price_notify/railsNotiflight/config/environment.rb"
require 'capybara/poltergeist'
# require 'Pry'
# require 'Nokogiri'
# require 'HTTParty'

Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, js_errors: false)
end

Capybara.default_driver = :poltergeist

browser = Capybara.current_session

flights = Flight.all
flights.each do |flight|
    if flight.tracking == false
        next
    end
    browser.visit "https://www.google.com/flights/?f=0&gl=us#search;f=#{flight.departureAirport};t=#{flight.arrivingAirport};d=#{flight.departureDate};r=#{flight.returnDate}"
    sleep(5)
    price = browser.all(".EIGTDNC-d-Ab").first.text
    price = price.gsub(/\D/,'').to_i
    price = Pricenumber.create(price: price, flight: flight)
    # puts price 
    lowerPrice = flight.lowerPrice.gsub(/\D/,'').to_i
    upperPrice = flight.upperPrice.gsub(/\D/,'').to_i
    puts price.price
    puts lowerPrice
    puts upperPrice
    if price.price < lowerPrice
        puts "current #{price.price} is lower than setpoint #{lowerPrice}"
        puts "sending email to #{flight.user.email}"
        UserMailer.notiflight_email_lower(flight, price.price).deliver_now
    end
    # UserMailer.notiflight_email_lower(flight, price.price).deliver_now
    if price.price > upperPrice
        puts "current #{price.price} is higher than #{upperPrice}"
        puts "sending email to #{flight.user.email}"
        UserMailer.notiflight_email_upper(flight, price.price).deliver_now
    end
    # if upperPrice < lowerPrice
    #     puts "yeah"
    # else
    #     puts "same or more"
    # end
    puts Time.now
    puts "-------"
end

# User.all.each do |user|
#     puts "sending trend email to #{user.email}"
#     UserMailer.notiflight_email(user).deliver_now
# end    
# puts "sending trend email to #{User.first.email}"
# UserMailer.notiflight_email(User.first).deliver_now

# browser.visit "https://www.google.com/flights/?f=0&gl=us#search;f=DFW,DAL;t=SFO;d=2017-09-08;r=2017-09-10"
# sleep(2)
# price = browser.all(".EIGTDNC-d-Ab").first.text
# puts price




# page = Nokogiri::HTML(browser.html)
# pp page
# Pry.start(binding)

# browser.find_field("destinationAirport").native.send_keys(:return)
# loop do
#     sleep(2)
#     if driver.execute_script('return document.readyState') == "complete"
#       break
#     end
# end