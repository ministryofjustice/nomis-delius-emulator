json.array!(@users) do |user|
  json.extract! user, :staffId
  json.status 'ACTIVE'
  json.position 'PRO'
end