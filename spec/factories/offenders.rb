FactoryBot.define do
  factory :offender do
    association :prison

    firstName { 'Fred' }
    gender { 'M' }
    imprisonmentStatus { 'SENT03'}
    lastName { 'Bloggs' }
    mainOffence { 'Robbery'}
    offenderNo { 'G1235FX'}
    receptionDate { Time.zone.today - 1.year }
  end
end
