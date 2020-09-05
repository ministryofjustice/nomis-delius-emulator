FactoryBot.define do
  factory :movement do
    association :offender
    typecode { "ADM" }
  end
end
