# frozen_string_literal: true

json.array!(@offenders) do |offender|
  json.offenderNo offender.offenderNo
  json.classificationCode offender.categoryCode
  json.classification "Cat #{offender.categoryCode}"
  json.approvalDate offender.updated_at.to_date
end
