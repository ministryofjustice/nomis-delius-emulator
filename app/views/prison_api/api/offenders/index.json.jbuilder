# frozen_string_literal: true

json.array!(@offenders) do |offender|
  json.extract! offender,
                :categoryCode, :mainOffence, :receptionDate,
                :firstName, :lastName, :offenderNo, :dateOfBirth,
                :imprisonmentStatus
  json.bookingId offender.booking_id
  json.agencyId offender.prison.code
  json.convictedStatus "Convicted"
  json.assignedLivingUnitDesc offender.cellLocation
end
