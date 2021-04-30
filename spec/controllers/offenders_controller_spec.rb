# frozen_string_literal: true

require "rails_helper"

RSpec.describe OffendersController, type: :controller do
  let(:prison) { create(:prison) }
  let!(:first_offender) { create(:offender, imprisonmentStatus: "LIFE", prison: prison, keyworker: build(:user)) }
  let!(:last_offender) { create(:offender, prison: prison) }
  let(:offenders) { [first_offender, last_offender] }

  render_views

  describe "search" do
    let(:o1) {
      {
        "prisonerNumber" => first_offender.offenderNo,
        "recall" => false,
        "indeterminateSentence" => true,
        "imprisonmentStatus" => "LIFE",
        "imprisonmentStatusDescription" => "Emulated LIFE Sentence",
        "cellLocation" => first_offender.cellLocation,
      }
    }
    let(:o2) {
      {
        "prisonerNumber" => last_offender.offenderNo,
        "recall" => false,
        "indeterminateSentence" => false,
        "imprisonmentStatus" => "SENT03",
        "imprisonmentStatusDescription" => "Emulated SENT03 Sentence",
        "cellLocation" => last_offender.cellLocation,
      }
    }

    it "returns the offenders" do
      post :search, body: { prisonerNumbers: [offenders.map(&:offenderNo)] }.to_json, format: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body))
        .to match_array([o1, o2])
    end
  end

  describe "keyworker" do
    it "returns the offenders" do
      get :keyworker, params: { prison_id: prison.code, offender_no: offenders.first.offenderNo }, format: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body))
        .to eq("firstName" => "Bob", "lastName" => "Smith")
    end
  end
end
