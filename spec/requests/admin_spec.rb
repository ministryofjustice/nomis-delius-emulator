# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Admin", type: :request do
  describe "authentication" do
    # Path to admin area
    let(:path) { admin_root_path }

    let(:auth_username) { nil }
    let(:auth_password) { nil }
    let(:auth_header) { ActionController::HttpAuthentication::Basic.encode_credentials(auth_username, auth_password) }

    def get_without_auth
      get path
    end

    def get_with_auth
      get path, headers: { "HTTP_AUTHORIZATION" => auth_header }
    end

    context "with authentication disabled" do
      before do
        Rails.configuration.admin_username = nil
        Rails.configuration.admin_password = nil
      end

      it "is world accessible" do
        get_without_auth
        expect(response).to have_http_status(:ok)
      end
    end

    context "with authentication enabled" do
      before do
        Rails.configuration.admin_username = "admin"
        Rails.configuration.admin_password = "secret"
      end

      context "with no credentials given" do
        it "returns 401 Unauthorized" do
          get_without_auth
          expect(response).to have_http_status(:unauthorized)
        end
      end

      context "with the wrong credentials given" do
        let(:auth_username) { "admin" }
        let(:auth_password) { "the_wrong_password" }

        it "returns 401 Unauthorized" do
          get_with_auth
          expect(response).to have_http_status(:unauthorized)
        end
      end

      context "with the correct credentials given" do
        let(:auth_username) { "admin" }
        let(:auth_password) { "secret" }

        it "lets you in" do
          get_with_auth
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end
end
