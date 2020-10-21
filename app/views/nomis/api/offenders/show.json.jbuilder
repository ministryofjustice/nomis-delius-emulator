# frozen_string_literal: true

json.array!([@offender]) do |offender|
  json.extract! offender,
                :gender, :mainOffence, :receptionDate,
                :firstName, :lastName, :offenderNo, :dateOfBirth,
                :imprisonmentStatus
  json.latestBookingId offender.booking.id
  json.latestLocationId offender.prison.code
end
