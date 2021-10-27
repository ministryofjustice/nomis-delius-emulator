# frozen_string_literal: true

require "rails_helper"

RSpec.describe OffendersController, type: :controller do
  render_views

  describe "keyworker" do
    let(:prison) { create(:prison) }
    let(:offender) { create(:offender, prison: prison, keyworker: build(:user)) }

    it "returns the offender's keyworker" do
      get :keyworker, params: { prison_id: prison.code, offender_no: offender.offenderNo }, format: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body))
        .to eq("firstName" => "Bob", "lastName" => "Smith")
    end
  end
end
