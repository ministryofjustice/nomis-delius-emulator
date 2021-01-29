# frozen_string_literal: true

FactoryBot.define do
  factory :offender do
    association :prison

    firstName { "Fred" }
    gender { "M" }
    imprisonmentStatus { "SENT03" }
    lastName { "Bloggs" }
    mainOffence { "Robbery" }
    sequence(:offenderNo) do |seq|
      pad = "%04d" % seq
      "G#{pad}FX"
    end
    receptionDate { Time.zone.today - 1.year }
    dateOfBirth { Time.zone.today - 20.years }
  end
end
