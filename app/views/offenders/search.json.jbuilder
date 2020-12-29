# frozen_string_literal: true

json.array!(@offenders) do |offender|
  json.prisonerNumber offender.offenderNo
  json.recall offender.recall_flag
end
