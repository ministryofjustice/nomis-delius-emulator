# frozen_string_literal: true

json.array!(@offenders) do |offender|
  json.prisonerNumber offender.offenderNo
  json.recall offender.recall_flag
  json.cellLocation offender.cellLocation
  json.indeterminateSentence offender.imprisonmentStatus == "LIFE"
  json.imprisonmentStatus offender.imprisonmentStatus
  json.imprisonmentStatusDescription "Emulated #{offender.imprisonmentStatus} Sentence"
end
