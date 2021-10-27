# frozen_string_literal: true

module SearchApi
  class OffendersController < ApplicationController
    # This is a POST action but is just a hidden GET really
    skip_before_action :verify_authenticity_token, only: :search_prisoner_numbers

    respond_to :json

    def search_prisoner_numbers
      @offenders = Offender.where(offenderNo: params["prisonerNumbers"]).includes(:booking)
    end

    def search_prison_id
      @offenders = Prison.find_by(code: params[:code]).offenders.includes(:booking)
    end
  end
end
