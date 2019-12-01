FactoryBot.define do
  factory :booking do
    home_detention_curfew_eligibility_date { "2019-12-01" }
    parole_eligibility_date { "2019-12-01" }
    release_date { "2019-12-01" }
    automatic_release_date { "2019-12-01" }
    conditional_release_date { "2019-12-01" }
    sentence_start_date { "2019-12-01" }
    tariff_date { "2019-12-01" }
  end
end
