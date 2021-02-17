# frozen_string_literal: true

json.array!([@booking]) do |booking|
  json.bookingId booking.offender.booking_id
  json.offenceDescription booking.offender.mainOffence
end
