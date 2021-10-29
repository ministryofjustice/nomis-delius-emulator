# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Assessments API", type: :request do
  let(:base_url) { "/assessments-api" }
  let(:offender) { create(:offender) }

  describe "GET /offenders/nomisId/{offenderNo}/assessments/summary" do
    it "returns a completed OASys Layer 3 assessment" do
      get "#{base_url}/offenders/nomisId/#{offender.offenderNo}/assessments/summary",
          params: { assessmentType: "LAYER_3", assessmentStatus: "COMPLETE" },
          as: :json

      expect(response).to be_successful
      expect(JSON.parse(response.body)).to eq(JSON.parse(
                                                [
                                                  { "completed" => offender.updated_at },
                                                ].to_json,
                                              ))
    end
  end
end
