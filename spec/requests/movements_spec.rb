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
  let(:movement_data) {
    {
      toAgency: prison.code,
      createDateTime: offender.movements.first.date.to_datetime,
      movementDate: offender.movements.first.date,
      movementType: "ADM",
      movementTime: "00:00:00",
      directionCode: "IN",
      offenderNo: offender.offenderNo,
    }
  }
  let(:headers) { { "ACCEPT" => "application/json" } }

  describe "GET /api/movements/offenders" do
    it "filters by type" do
      post "/prison_api/api/movements/offenders?latestOnly=true&movementTypes=ADM", params: [offender.offenderNo].to_json, headers: headers
      expect(response).to have_http_status(:success)

      expect(JSON.parse(response.body)).to eq(JSON.parse([movement_data].to_json))
    end
  end

  describe "#by_date" do
    let(:m1) {
      {
        toAgency: prison.code,
        createDateTime: offender.movements.first.date.to_datetime,
        movementDate: offender.movements.first.date,
        movementTime: "00:00:00",
        movementType: "ADM",
        directionCode: "IN",
        offenderNo: offender.offenderNo,
      }
    }
    let(:m2) {
      {
        fromAgency: prison.code,
        toAgency: prison2.code,
        createDateTime: movement.date.to_datetime,
        movementDate: movement.date,
        movementTime: "00:00:00",
        movementType: "TRN",
        directionCode: "IN",
        offenderNo: offender.offenderNo,
      }
    }

    it "works" do
      get "/prison_api/api/movements", params: { fromDateTime: 1.day.ago, movementDate: Time.zone.today }, headers: headers
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).
        to eq(JSON.parse([m1, m2].to_json))
    end
  end
end
