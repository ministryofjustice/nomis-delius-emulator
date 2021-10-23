# frozen_string_literal: true

json.array!(@movements) do |movement|
  json.fromAgency movement.from_prison.code if movement.from_prison
  json.toAgency movement.to_prison.code
  json.createDateTime movement.date.to_time
  json.movementDate movement.date
  json.movementTime "00:00:00"
  json.offenderNo movement.offender.offenderNo
  json.movementType movement.typecode
  json.directionCode movement.directionCode
end
