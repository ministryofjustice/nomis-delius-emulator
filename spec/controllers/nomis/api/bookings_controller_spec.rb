# frozen_string_literal: true

require "rails_helper"

RSpec.describe Nomis::Api::BookingsController, type: :controller do
  let(:prison) { create(:prison) }
  let(:offender) { create(:offender, prison: prison) }

  render_views

  context "with all fields" do
    let(:booking) { create(:booking, offender: offender) }

    it "index returns json" do
      post :index, body: [booking.id + Offender::BOOKING_ID_OFFSET].to_json, format: :json
      expect(response).to be_successful

      expect(JSON.parse(response.body))
          .to eq([
                   { bookingId: booking.id + Offender::BOOKING_ID_OFFSET,
                     firstName: offender.firstName,
                     offenderNo: offender.offenderNo,
                     lastName: offender.lastName,
                     sentenceDetail: {
                       bookingId: booking.id + Offender::BOOKING_ID_OFFSET,
                       "automaticReleaseDate" => "2019-12-01",
                       "conditionalReleaseDate" => "2019-12-01",
                       "homeDetentionCurfewEligibilityDate" => "2019-12-01",
                       "paroleEligibilityDate" => "2019-12-01",
                       "releaseDate" => "2019-12-01",
                       "sentenceStartDate" => "2019-12-01",
                       "tariffDate" => "2019-12-01",
                     }.stringify_keys }.stringify_keys,
                 ])
    end

    it "main offence returns data from offender" do
      get :show, params: { id: booking.id + Offender::BOOKING_ID_OFFSET }, format: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)).to eq([{ bookingId: booking.id + Offender::BOOKING_ID_OFFSET,
                                               offenceDescription: booking.offender.mainOffence }.stringify_keys])
    end
  end

  context "with fields missing" do
    let(:booking) { create(:booking, offender: offender, automaticReleaseDate: nil) }

    it "omits nil fields" do
      post :index, body: [booking.id + Offender::BOOKING_ID_OFFSET].to_json, format: :json
      expect(response).to be_successful

      expect(JSON.parse(response.body))
          .to eq([{ bookingId: booking.id + Offender::BOOKING_ID_OFFSET,
                    firstName: offender.firstName,
                    offenderNo: offender.offenderNo,
                    lastName: offender.lastName,
                    sentenceDetail: {
                      bookingId: booking.id + Offender::BOOKING_ID_OFFSET,
                      "conditionalReleaseDate" => "2019-12-01",
                      "homeDetentionCurfewEligibilityDate" => "2019-12-01",
                      "paroleEligibilityDate" => "2019-12-01",
                      "releaseDate" => "2019-12-01",
                      "sentenceStartDate" => "2019-12-01",
                      "tariffDate" => "2019-12-01",
                    }.stringify_keys }.stringify_keys])
    end
  end
end
