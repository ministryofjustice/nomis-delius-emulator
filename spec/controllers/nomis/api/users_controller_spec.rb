# frozen_string_literal: true

require "rails_helper"

RSpec.describe Nomis::Api::UsersController, type: :controller do
  before do
    create(:prison)
  end

  render_views

  let(:prison) { Prison.last }

  context "with a user" do
    before do
      create(:user, username: "BOB")
    end

    let(:user) { User.last }

    describe "GET #show" do
      it "returns http success and upcases name" do
        get :show, params: { staffId: user.id }, format: :json
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to eq({ staffId: user.staffId,
                                                  firstName: user.firstName.upcase,
                                                  lastName: user.lastName.upcase }.stringify_keys)
      end
    end

    describe "GET #by_username" do
      it "returns http success" do
        get :by_username, params: { username: "BOB" }, format: :json
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to eq({ staffId: user.staffId,
                                                  firstName: user.firstName,
                                                  lastName: user.lastName,
                                                  username: "BOB",
                                                  activeCaseLoadId: prison.code }.stringify_keys)
      end
    end

    describe "GET #emails" do
      it "returns http success" do
        get :emails, params: { staffId: user.staffId }, format: :json
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to eq([user.email])
      end
    end

    describe "GET #caseloads" do
      it "returns http success" do
        get :caseloads, params: { staffId: user.staffId }, format: :json
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to eq([{ caseLoadId: prison.code, type: "INST" }].map(&:stringify_keys))
      end
    end

    describe "GET #roles" do
      it "returns http success, and capitalizes name" do
        get :roles, params: { prison_id: prison.code }, format: :json
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body))
          .to eq([{ staffId: user.staffId,
                    position: user.position,
                    positionDescription: "Probation Officer",
                    firstName: user.firstName,
                    lastName: user.lastName }].map(&:stringify_keys))
      end
    end
  end

  context "without a user" do
    describe "GET #show" do
      it "returns 404" do
        get :show, params: { staffId: 123456 }, format: :json
        expect(response).to have_http_status(404)
      end
    end

    describe "GET #by_username" do
      it "returns 404" do
        get :by_username, params: { username: "BOB" }, format: :json
        expect(response).to have_http_status(404)
      end
    end
  end
end
