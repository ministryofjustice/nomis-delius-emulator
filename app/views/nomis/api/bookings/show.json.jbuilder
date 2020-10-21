# frozen_string_literal: true

json.array!([@booking]) do |booking|
  json.bookingId booking.id
  json.offenceDescription "Test Offence Description"
end
