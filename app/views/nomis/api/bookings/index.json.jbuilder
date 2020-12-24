# frozen_string_literal: true

json.array!(@bookings) do |booking|
  json.bookingId booking.id
  json.firstName booking.offender.firstName
  json.lastName booking.offender.lastName
  json.offenderNo booking.offender.offenderNo
  json.sentenceDetail do
    json.bookingId booking.id
    # [:homeDetentionCurfewEligibilityDate].each do |field|
    #   value = booking.public_send(field)
    #   json.public_send(field, value) if value
    # end
    json.homeDetentionCurfewEligibilityDate booking.homeDetentionCurfewEligibilityDate if booking.homeDetentionCurfewEligibilityDate
    json.paroleEligibilityDate booking.paroleEligibilityDate if booking.paroleEligibilityDate
    json.releaseDate booking.releaseDate if booking.releaseDate
    json.automaticReleaseDate booking.automaticReleaseDate if booking.automaticReleaseDate
    json.conditionalReleaseDate booking.conditionalReleaseDate if booking.conditionalReleaseDate
    json.tariffDate booking.tariffDate if booking.tariffDate
    json.extract! booking, :sentenceStartDate
  end
end
