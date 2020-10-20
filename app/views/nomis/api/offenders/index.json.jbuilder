json.array!(@offenders) do |offender|
  json.extract! offender,
                :gender, :categoryCode, :mainOffence, :receptionDate,
                :firstName, :lastName, :offenderNo,
                :imprisonmentStatus
  json.bookingId offender.booking.id
  json.agencyId offender.prison.code
end