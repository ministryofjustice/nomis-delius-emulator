# frozen_string_literal: true

json.content do
  json.array! @offenders, partial: "offender", as: :offender
end
