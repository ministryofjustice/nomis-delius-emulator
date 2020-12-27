# frozen_string_literal: true

if @offender.present?
  json.array!([@offender]) do |offender|
    json.extract! offender,
                  :gender, :mainOffence, :receptionDate,
                  :firstName, :lastName, :offenderNo, :dateOfBirth,
                  :imprisonmentStatus
    json.latestBookingId offender.booking.id
    json.latestLocationId offender.prison.code
  end
else
  json.array []
end
