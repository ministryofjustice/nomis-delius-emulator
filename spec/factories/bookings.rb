# frozen_string_literal: true

FactoryBot.define do
  factory :booking do
    homeDetentionCurfewEligibilityDate { "2019-12-01" }
    paroleEligibilityDate { "2019-12-01" }
    releaseDate { "2019-12-01" }
    automaticReleaseDate { "2019-12-01" }
    conditionalReleaseDate { "2019-12-01" }
    sentenceStartDate { "2019-12-01" }
    tariffDate { "2019-12-01" }
  end
end
