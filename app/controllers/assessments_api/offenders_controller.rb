# frozen_string_literal: true

module AssessmentsApi
  class OffendersController < ApplicationController
    respond_to :json

    def assessments
      @offenders = Offender.where(offenderNo: params["offender_no"])
    end
  end
end
