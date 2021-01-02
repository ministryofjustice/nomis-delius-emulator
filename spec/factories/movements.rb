# frozen_string_literal: true

FactoryBot.define do
  factory :movement do
    association :offender
    typecode { "ADM" }
    date { Date.today }
    directionCode { 'IN' }
  end
end
