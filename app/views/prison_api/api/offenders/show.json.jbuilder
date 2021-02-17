# frozen_string_literal: true

if @offender.present?
  json.array!([@offender]) do |offender|
    json.extract! offender,
                  :mainOffence, :receptionDate,
                  :firstName, :lastName, :offenderNo, :dateOfBirth,
                  :imprisonmentStatus
    json.latestBookingId offender.booking_id
    json.latestLocationId offender.prison.code
    json.convictedStatus "Convicted"
    json.internalLocation offender.cellLocation
  end
else
  json.array! []
end
