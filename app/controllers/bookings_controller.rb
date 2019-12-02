class BookingsController < ApplicationController
  respond_to :json

  def index
    booking_ids = JSON.parse(request.body.string)
    @bookings = Booking.includes(:offender).find(booking_ids)
  end
end
