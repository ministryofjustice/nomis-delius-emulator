# frozen_string_literal: true

require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

private

  def not_found
    render json: { error: "Not found" }.to_json, status: :not_found
  end
end
