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
  let(:movement_data) do
    {
      toAgency: prison.code,
      createDateTime: offender.movements.first.date.to_time,
      movementDate: offender.movements.first.date,
      movementType: "ADM",
      movementTime: "00:00:00",
      directionCode: "IN",
      offenderNo: offender.offenderNo,
    }
  end
  let(:headers) { { "ACCEPT" => "application/json" } }

  describe "GET /api/movements/offenders" do
    it "filters by type" do
      post "/prison_api/api/movements/offenders?latestOnly=true&movementTypes=ADM", params: [offender.offenderNo].to_json, headers: headers
      expect(response).to have_http_status(:success)

      expect(JSON.parse(response.body)).to eq(JSON.parse([movement_data].to_json))
    end
  end

  describe "#by_date" do
    let(:m1) do
      {
        toAgency: prison.code,
        createDateTime: offender.movements.first.date.to_time,
        movementDate: offender.movements.first.date,
        movementTime: "00:00:00",
        movementType: "ADM",
        directionCode: "IN",
        offenderNo: offender.offenderNo,
      }
    end
    let(:m2) do
      {
        fromAgency: prison.code,
        toAgency: prison2.code,
        createDateTime: movement.date.to_time,
        movementDate: movement.date,
        movementTime: "00:00:00",
        movementType: "TRN",
        directionCode: "IN",
        offenderNo: offender.offenderNo,
      }
    end

    it "works for 4 days ago" do
      get "/prison_api/api/movements", params: { fromDateTime: 5.days.ago, movementDate: 4.days.ago }, headers: headers
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body))
        .to eq(JSON.parse([m1].to_json))
    end

    it "works for today" do
      get "/prison_api/api/movements", params: { fromDateTime: 1.day.ago, movementDate: Time.zone.today }, headers: headers
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body))
        .to eq(JSON.parse([m2].to_json))
    end
  end
end
