# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Nomis::Api::OffendersController, type: :controller do
  let(:prison) { create(:prison) }

  context 'one offender' do
    let!(:offender) { create(:offender, prison: prison) }

    render_views

    it 'gets index' do
      get :index, params: { prison_id: prison.code }, format: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)).to eq([{ 'categoryCode' => nil, 'convictedStatus' => offender.convictedStatus,
                                                 'firstName' => offender.firstName, 'gender' => offender.gender,
                                                 'imprisonmentStatus' => offender.imprisonmentStatus, 'lastName' => offender.lastName,
                                                 'mainOffence' => offender.mainOffence, 'offenderNo' => offender.offenderNo,
                                                 'receptionDate' => offender.receptionDate.to_s }])
    end
  end

  context 'paging' do
    before do
      1.upto(10) { |i| create(:offender, prison: prison, offenderNo: "G#{1000 + i}FX") }
    end

    it 'gets the first 5 offenders' do
      request.headers["Page-Limit"] = 5
      request.headers["Page-Offset"] = 0

      get :index, params: { prison_id: prison.code }, format: :json
      expect(response).to be_successful
      expect(assigns(:offenders).map(&:offenderNo)).to eq(['G1001FX', 'G1002FX', 'G1003FX', 'G1004FX', 'G1005FX'])
    end

    it 'gets the next 5 offenders' do
      request.headers["Page-Limit"] = 5
      request.headers["Page-Offset"] = 5

      get :index, params: { prison_id: prison.code }, format: :json
      expect(response).to be_successful
      expect(assigns(:offenders).map(&:offenderNo)).to eq(['G1006FX', 'G1007FX', 'G1008FX', 'G1009FX', 'G1010FX'])
    end
  end
end
