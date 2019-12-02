require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  let(:prison) { create(:prison) }
  let(:offender) { create(:offender, prison: prison)}
  let(:booking) { create(:booking, offender: offender) }

  it 'posts index' do
    post :index, body: [booking.id].to_json, format: :json
    expect(response).to be_successful
    expect(assigns(:bookings)).to eq([booking])
  end

  context 'with render views' do
    render_views

    it 'returns json' do
      post :index, body: [booking.id].to_json, format: :json
      expect(response).to be_successful

      expect(JSON.parse(response.body)).to eq([{'firstName' => offender.firstName,
                                                'lastName' => offender.lastName,
                                                "automaticReleaseDate"=>"2019-12-01",
                                                "conditionalReleaseDate"=>"2019-12-01",
                                                "homeDetentionCurfewEligibilityDate"=>"2019-12-01",
                                                "paroleEligibilityDate"=>"2019-12-01",
                                                "releaseDate"=>"2019-12-01",
                                                "sentenceStartDate"=>"2019-12-01",
                                                "tariffDate"=>"2019-12-01"}])
    end
  end
end
