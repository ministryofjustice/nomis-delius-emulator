# frozen_string_literal: true

module Nomis
  module Api
    class BookingsController < ApplicationController
      respond_to :json

      # This is a POST action but is just a hidden GET really
      skip_before_action :verify_authenticity_token, only: :index

      def index
        booking_ids = JSON.parse(request.body.string)
        @bookings = Booking.includes(:offender).find(booking_ids.map { |id| id - Offender::BOOKING_ID_OFFSET })
      end

      def show
        @booking = Booking.find params[:id].to_i - Offender::BOOKING_ID_OFFSET
      end
    end
  end
end
