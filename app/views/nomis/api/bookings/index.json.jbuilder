json.array!(@bookings) do |booking|
  json.extract! booking,
                :homeDetentionCurfewEligibilityDate, :paroleEligibilityDate,
                :releaseDate, :automaticReleaseDate, :conditionalReleaseDate,
                :sentenceStartDate, :tariffDate
  json.firstName booking.offender.firstName
  json.lastName booking.offender.lastName
end
