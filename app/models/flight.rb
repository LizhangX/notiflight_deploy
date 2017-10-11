class Flight < ApplicationRecord
    belongs_to :user
    has_many :prices, dependent: :destroy

    validates :departureAirport, :arrivingAirport, :departureDate, :returnDate, :lowerPrice, :upperPrice, presence: true
    validates :tracking, inclusion: { in: [true, false] }
    validates_date :departureDate, on_or_after: :today
    validates_date :returnDate, on_or_after: :today

    def to_s
        return "Tracking: #{self.tracking}"
    end
end
