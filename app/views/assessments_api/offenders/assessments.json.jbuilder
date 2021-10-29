# frozen_string_literal: true

json.array!(@offenders) do |offender|
  # Use the offender 'updated at' timestamp for now.
  # If more control is needed, fields could be added to Active Admin.
  json.completed offender.updated_at
end
