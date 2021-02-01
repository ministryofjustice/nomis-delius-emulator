# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Movements", type: :request do
  before do
    create(:movement, offender: offender, from_prison: prison, to_prison: prison2, typecode: "TRN")
  end

  let(:prison) { create(:prison) }
  let(:prison2) { create(:prison) }
  let(:offender) { create(:offender, prison: prison) }
  let(:movement) { Movement.last }

  describe "GET /api/movements" do
    it "filters by type" do
      headers = { "ACCEPT" => "application/json" }
      post "/prison_api/api/movements/offenders?latestOnly=true&movementTypes=ADM", params: [offender.offenderNo].to_json, headers: headers
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
