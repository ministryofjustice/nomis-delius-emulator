# frozen_string_literal: true

module PrisonApi
  module Api
    class OffendersController < ApplicationController
      respond_to :json

      # This is a POST action but is just a hidden GET really
      skip_before_action :verify_authenticity_token, only: :assessments

      def assessments
        offender_ids = JSON.parse(request.body.string)
        @offenders = Offender.where(offenderNo: offender_ids)
                             .select { |o| o.categoryCode.present? }
      end
    end
  end
end
