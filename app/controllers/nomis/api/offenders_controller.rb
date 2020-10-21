# frozen_string_literal: true

module Nomis
  module Api
    class OffendersController < ApplicationController
      respond_to :json

      def index
        offset = request.headers["Page-Offset"]
        limit = request.headers["Page-Limit"]
        prison = Prison.find_by(code: params[:prison_id])
        @offenders = prison.offenders.joins(:booking).offset(offset).limit(limit)
      end

      def show
        @offender = Offender.find_by(offenderNo: params[:offender_no])
      end
    end
  end
end
