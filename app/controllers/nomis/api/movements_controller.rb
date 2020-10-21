module Nomis
  module Api
    class MovementsController < ApplicationController
      respond_to :json

      # This is a POST action but is just a hidden GET really
      skip_before_action :verify_authenticity_token

      def index
        offender_ids = JSON.parse(request.body.string)
        @movements = Offender.includes(:movements).where(offenderNo: offender_ids).flat_map(&:movements)
      end
    end
  end
end

