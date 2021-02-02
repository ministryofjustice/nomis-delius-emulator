# frozen_string_literal: true

require "rails_helper"

RSpec.describe PrisonApi::Api::MovementsController, type: :controller do
  before do
    create(:movement, offender: offender, from_prison: prison, to_prison: prison2, typecode: "TRN")
  end

  let(:prison) { create(:prison) }
  let(:prison2) { create(:prison) }
  let(:offender) { create(:offender, prison: prison) }
  let(:movement) { Movement.last }

  render_views

  describe "#by_date" do
    let(:m1) {
      {
      toAgency: prison.code,
      createDateTime: JSON.parse(offender.movements.first.date.to_datetime.to_json),
      movementType: "ADM",
      directionCode: "IN",
      offenderNo: offender.offenderNo,
    }
    }
    let(:m2) {
      {
        fromAgency: prison.code,
        toAgency: prison2.code,
        createDateTime: JSON.parse(movement.date.to_datetime.to_json),
        movementType: "TRN",
        directionCode: "IN",
        offenderNo: offender.offenderNo,
      }
    }

    it "works" do
      get :by_date, params: { fromDateTime: 1.day.ago, movementDate: Time.zone.today }, format: :json
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).
        to eq([m1, m2].map(&:stringify_keys))
    end
  end
end
