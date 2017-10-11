class CreateFlights < ActiveRecord::Migration[5.1]
  def change
    create_table :flights do |t|
      t.string :departureAirport
      t.string :arrivingAirport
      t.date :departureDate
      t.date :returnDate
      t.string :lowerPrice
      t.string :upperPrice
      t.boolean :tracking
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
