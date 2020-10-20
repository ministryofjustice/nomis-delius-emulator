# frozen_string_literal: true

json.array!(@users) do |user|
  json.extract! user, :staffId
  json.status "ACTIVE"
  json.position "PRO"
end
