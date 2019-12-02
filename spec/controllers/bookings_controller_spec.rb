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
end
