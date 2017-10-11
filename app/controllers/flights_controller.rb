class FlightsController < ApplicationController
    skip_before_action :require_login
    def create
        flight = Flight.new(flight_params)
        flight.user = current_user
        flight.tracking = true
        unless flight.save
          flash[:notice] = flight.errors.full_messages
        else
          flash[:notice] = ["Successfully schedule!"]
        end
        return redirect_to user_path(flight.user.id)
    end

    def track
        flight = Flight.find_by_id(params[:id])
        # puts 'before', flight.to_s
        flight.tracking = !flight.tracking
        # puts 'after', flight.to_s
        flight.save
        # puts flight.errors.full_messages
        return redirect_to user_path(flight.user.id)
    end

    def destroy
        flight = Flight.find_by_id(params[:id]).destroy
        puts flight
        return redirect_to user_path(flight.user.id)
    end

    private
        def flight_params
            params.require(:flight).permit(:departureAirport, :arrivingAirport, :departureDate, :returnDate, :lowerPrice, :upperPrice)
        end
    
end
