class BookingsController < ApplicationController
  respond_to :json

  # TODO: This is supposed to just be a raw array rather than a parameter according to NOMIS docs
  def index
    @bookings = Booking.find(params[:booking_ids])
  end
end
