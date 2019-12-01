# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OffendersController, type: :controller do
  let(:prison) { create(:prison) }
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
