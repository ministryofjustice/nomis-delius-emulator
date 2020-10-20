json.array!(@caseloads) do |prison|
  json.caseLoadId prison.code
  json.type 'INST'
end