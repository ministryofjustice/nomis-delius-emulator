# frozen_string_literal: true

module Nomis
  module Api
    class OffendersController < ApplicationController
      respond_to :json

      # This is a POST action but is just a hidden GET really
      skip_before_action :verify_authenticity_token, only: :assessments

      def index
        offset = request.headers["Page-Offset"]
        limit = request.headers["Page-Limit"]
        prison = Prison.find_by(code: params[:prison_id])
        @offenders = prison.offenders.joins(:booking).offset(offset).limit(limit)
      end

      def show
        @offender = Offender.find_by(offenderNo: params[:offender_no])
      end

      def assessments
        offender_ids = JSON.parse(request.body.string)
        @offenders = Offender.where(offenderNo: offender_ids)
      end
    end
  end
end
