# frozen_string_literal: true

require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  # Apply HTTP Basic auth, requiring the credentials specified in the environment
  def authenticate_admin_user!
    expect_username = Rails.configuration.admin_username
    expect_password = Rails.configuration.admin_password

    return if expect_username.blank? && expect_password.blank?

    authenticate_or_request_with_http_basic do |username, password|
      username == expect_username && password == expect_password
    end
  end

private

  def not_found
    render json: { error: "Not found" }.to_json, status: :not_found
  end
end
