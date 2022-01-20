# frozen_string_literal: true

FactoryBot.define do
  factory :offender do
    association :prison

    categoryCode { "C" }
    firstName { "Fred" }
    imprisonmentStatus { "SENT03" }
    lastName { "Bloggs" }
    mainOffence { "Robbery" }
    sequence(:offenderNo) do |seq|
      pad = sprintf("%04d", seq)
      "G#{pad}FX"
    end
    receptionDate { Time.zone.today - 1.year }
    dateOfBirth { Time.zone.today - 20.years }
    cellLocation { "Location" }
    dischargedHospitalDescription { "Hospital" }
    restrictedPatient { false }
    supportingPrisonId { "LEI" }
  end
end
