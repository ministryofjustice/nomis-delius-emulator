# frozen_string_literal: true

json.array!(@bookings) do |booking|
  json.bookingId booking.id
  json.firstName booking.offender.firstName
  json.lastName booking.offender.lastName
  json.offenderNo booking.offender.offenderNo
  json.sentenceDetail do
    json.bookingId booking.id
    json.extract! booking,
                  :homeDetentionCurfewEligibilityDate, :paroleEligibilityDate,
                  :releaseDate, :automaticReleaseDate, :conditionalReleaseDate,
                  :sentenceStartDate, :tariffDate
  end
end
