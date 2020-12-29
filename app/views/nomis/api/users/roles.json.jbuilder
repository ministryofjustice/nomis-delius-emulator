# frozen_string_literal: true

json.array!(@users) do |user|
  json.extract! user, :staffId, :firstName, :lastName, :position
  json.positionDescription user.position == "PO" ? "Probation Officer" : "Prison Officer"
end
