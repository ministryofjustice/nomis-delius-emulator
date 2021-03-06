# frozen_string_literal: true

require "rails_helper"

RSpec.describe PrisonApi::Api::OffendersController, type: :controller do
  let(:prison) { create(:prison) }

  context "with one offender" do
    let!(:offender) { create(:offender, prison: prison, booking: build(:booking)) }
    let!(:offender_no_location) { create(:offender, cellLocation: nil, prison: prison, booking: build(:booking)) }
    let(:offender_json) {
      {
        firstName: offender.firstName,
        bookingId: offender.booking.id,
        agencyId: prison.code,
        imprisonmentStatus: offender.imprisonmentStatus,
        convictedStatus: "Convicted",
        dateOfBirth: offender.dateOfBirth.to_s,
        lastName: offender.lastName,
        mainOffence: offender.mainOffence,
        offenderNo: offender.offenderNo,
        assignedLivingUnitDesc: offender.cellLocation,
        receptionDate: offender.receptionDate.to_s,
      }.stringify_keys
    }

    let(:single_json) {
      { firstName: offender.firstName,
        latestBookingId: offender.booking.id,
        latestLocationId: prison.code,
        currentlyInPrison: "Y",
        imprisonmentStatus: offender.imprisonmentStatus,
        internalLocation: offender.cellLocation,
        dateOfBirth: offender.dateOfBirth.to_s,
        convictedStatus: "Convicted",
        lastName: offender.lastName,
        mainOffence: offender.mainOffence,
        offenderNo: offender.offenderNo,
        receptionDate: offender.receptionDate.to_s }.stringify_keys
    }
    let(:no_location_json) {
      {
        firstName: offender_no_location.firstName,
        bookingId: offender_no_location.booking.id,
        agencyId: prison.code,
        imprisonmentStatus: offender_no_location.imprisonmentStatus,
        convictedStatus: "Convicted",
        dateOfBirth: offender_no_location.dateOfBirth.to_s,
        lastName: offender_no_location.lastName,
        mainOffence: offender_no_location.mainOffence,
        offenderNo: offender_no_location.offenderNo,
        receptionDate: offender_no_location.receptionDate.to_s,
      }.stringify_keys
    }
    let(:single_nolocation_json) {
      { firstName: offender_no_location.firstName,
        latestBookingId: offender_no_location.booking.id,
        latestLocationId: prison.code,
        currentlyInPrison: "Y",
        imprisonmentStatus: offender_no_location.imprisonmentStatus,
        dateOfBirth: offender_no_location.dateOfBirth.to_s,
        convictedStatus: "Convicted",
        lastName: offender_no_location.lastName,
        mainOffence: offender_no_location.mainOffence,
        offenderNo: offender_no_location.offenderNo,
        receptionDate: offender_no_location.receptionDate.to_s }.stringify_keys
    }

    render_views

    it "assessments endpoint returns category code" do
      post :assessments, body: [offender.offenderNo].to_json, format: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)).to eq([{ offenderNo: offender.offenderNo,
                                                 classificationCode: "C",
                                                 classification: "Cat C",
                                                 approvalDate: offender.updated_at.to_date.to_s }.stringify_keys])
    end

    it "gets index" do
      get :index, params: { prison_id: prison.code }, format: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body))
        .to eq([offender_json, no_location_json])
    end

    context "with a location" do
      it "gets show" do
        get :show, params: { offender_no: offender.offenderNo }, format: :json
        expect(response).to be_successful
        expect(JSON.parse(response.body)).to eq([single_json])
      end
    end

    context "without a location" do
      it "doesnt have a location" do
        get :show, params: { offender_no: offender_no_location.offenderNo }, format: :json
        expect(response).to be_successful
        expect(JSON.parse(response.body)).to eq([single_nolocation_json])
      end
    end
  end

  context "without a booking" do
    before { create(:offender, prison: prison, booking: nil) }

    let(:offender) { Offender.last }

    render_views

    it "gets index" do
      get :index, params: { prison_id: prison.code }, format: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)).to eq([])
    end
  end

  context "when paging" do
    before do
      1.upto(10) { |i| create(:offender, prison: prison, offenderNo: "G#{1000 + i}FX", booking: build(:booking)) }
    end

    it "gets the first 5 offenders" do
      request.headers["Page-Limit"] = 5
      request.headers["Page-Offset"] = 0

      get :index, params: { prison_id: prison.code }, format: :json
      expect(response).to be_successful
      expect(assigns(:offenders).map(&:offenderNo)).to eq(%w[G1001FX G1002FX G1003FX G1004FX G1005FX])
    end

    it "gets the next 5 offenders" do
      request.headers["Page-Limit"] = 5
      request.headers["Page-Offset"] = 5

      get :index, params: { prison_id: prison.code }, format: :json
      expect(response).to be_successful
      expect(assigns(:offenders).map(&:offenderNo)).to eq(%w[G1006FX G1007FX G1008FX G1009FX G1010FX])
    end
  end

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
