# frozen_string_literal: true

require "rails_helper"

RSpec.describe Nomis::Api::MovementsController, type: :controller do
  before do
    create(:movement, offender: offender, from_prison: prison, to_prison: prison2, typecode: "TRN")
  end

  let(:prison) { create(:prison) }
  let(:prison2) { create(:prison) }
  let(:offender) { create(:offender, prison: prison) }
  let(:movement) { Movement.last }

  render_views

  describe "GET #index" do
    it "returns http success" do
      post :index, params: { latestOnly: true, movementTypes: %w[ADM TRN] }, body: [offender.offenderNo].to_json, format: :json
      expect(response).to have_http_status(:success)

      expect(JSON.parse(response.body)).
          to eq([{
                     toAgency: prison.code,
                     createDateTime: JSON.parse(offender.movements.first.created_at.to_json),
                     movementType: "ADM",
                     directionCode: "IN",
                     offenderNo: offender.offenderNo,
                 },
                 {
                     fromAgency: prison.code,
                     toAgency: prison2.code,
                     createDateTime: JSON.parse(movement.created_at.to_json),
                     movementType: "TRN",
                     directionCode: "IN",
                     offenderNo: offender.offenderNo,
                 }].map(&:stringify_keys))
    end

    it "filters by type" do
      post :index, params: { latestOnly: true, movementTypes: %w[ADM] }, body: [offender.offenderNo].to_json, format: :json
      expect(response).to have_http_status(:success)

      expect(JSON.parse(response.body)).
          to eq([{
                     toAgency: prison.code,
                     createDateTime: JSON.parse(offender.movements.first.created_at.to_json),
                     movementType: "ADM",
                     directionCode: "IN",
                     offenderNo: offender.offenderNo,
                 }].map(&:stringify_keys))
    end
  end
end
