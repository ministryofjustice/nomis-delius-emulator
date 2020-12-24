# frozen_string_literal: true

class OffendersController < ApplicationController
  # This is a POST action but is just a hidden GET really
  skip_before_action :verify_authenticity_token, only: :search

  respond_to :json

  def search
    ids = JSON.parse(request.body.string).fetch("prisonerNumbers")
    @offenders = Offender.where(offenderNo: ids)
  end
end
