# frozen_string_literal: true

json.array!(@caseloads) do |prison|
  json.caseLoadId prison.code
  json.type "INST"
end
