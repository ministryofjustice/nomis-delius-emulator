require 'rails_helper'

RSpec.describe OffendersController, type: :controller do
  let(:prison) { create(:prison) }

  before do
    create(:offender, prison: prison)
  end

  it 'gets index' do
    get :index, params: { prison_id: prison.code }, format: :json
  end
end
