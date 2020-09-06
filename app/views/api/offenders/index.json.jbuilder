json.array!(@offenders) do |offender|
  json.extract! offender,
                :gender, :categoryCode, :mainOffence, :receptionDate,
                :firstName, :lastName, :offenderNo, :convictedStatus,
                :imprisonmentStatus
end