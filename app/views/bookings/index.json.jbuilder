json.array!(@bookings) do |booking|
  json.extract! booking,
                :homeDetentionCurfewEligibilityDate,:paroleEligibilityDate,
                :releaseDate,:automaticReleaseDate,:conditionalReleaseDate,
                :sentenceStartDate, :tariffDate
end