# frozen_string_literal: true

json.array!(@offenders) do |offender|
  json.classificationCode offender.categoryCode
end