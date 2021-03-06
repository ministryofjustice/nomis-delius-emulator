# frozen_string_literal: true

module PrisonApi
  module Api
    class BookingsController < ApplicationController
      respond_to :json

      # This is a POST action but is just a hidden GET really
      skip_before_action :verify_authenticity_token, only: :index

      def index
        booking_ids = JSON.parse(request.body.string)
        @bookings = Booking.includes(:offender).find(booking_ids)
      end

      def show
        @booking = Booking.find params[:id].to_i
      end
    end
  end
end
