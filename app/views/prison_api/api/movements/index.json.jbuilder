# frozen_string_literal: true

json.array!(@movements) do |movement|
  json.fromAgency movement.from_prison.code if movement.from_prison
  json.toAgency movement.to_prison.code
  json.createDateTime movement.date.to_datetime
  json.offenderNo movement.offender.offenderNo
  json.movementType movement.typecode
  json.directionCode movement.directionCode
end
