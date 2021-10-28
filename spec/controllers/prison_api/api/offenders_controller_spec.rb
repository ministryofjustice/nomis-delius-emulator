# frozen_string_literal: true

require "rails_helper"

RSpec.describe PrisonApi::Api::OffendersController, type: :controller do
  let(:prison) { create(:prison) }

  describe "#assessments" do
    context "when offenders are missing a category code" do
      let!(:offender_cat_a) { create(:offender, categoryCode: "A") }
      let!(:offender_cat_d) { create(:offender, categoryCode: "D") }
      let!(:offender_no_cat) { create(:offender, categoryCode: nil) }

      render_views

      it "excludes them from the list" do
        offender_nos = [offender_cat_a, offender_cat_d, offender_no_cat].map(&:offenderNo)
        post :assessments, body: offender_nos.to_json, format: :json
        expect(response).to be_successful

        response_array = JSON.parse(response.body)
        expect(response_array.count).to eq(2)
        expect(response_array.map { |a| [a["offenderNo"], a["classificationCode"]] })
          .to eq [
            [offender_cat_a.offenderNo, "A"],
            [offender_cat_d.offenderNo, "D"],
          ]
      end
    end
  end
end
