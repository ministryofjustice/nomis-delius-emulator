module Nomis
  module Api
    class BookingsController < ApplicationController
      respond_to :json

      # This is a POST action but is just a hidden GET really
      skip_before_action :verify_authenticity_token

      def index
        booking_ids = JSON.parse(request.body.string)
        @bookings = Booking.includes(:offender).find(booking_ids)
      end
    end
  end
end
