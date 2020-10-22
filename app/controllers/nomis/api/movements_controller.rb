# frozen_string_literal: true

module Nomis
  module Api
    class MovementsController < ApplicationController
      respond_to :json

      # This is a POST action but is just a hidden GET really
      skip_before_action :verify_authenticity_token

      def index
        offender_ids = JSON.parse(request.body.string)
        types = params[:movementTypes]
        @movements = Offender.includes(:movements).joins(:movements).
            where(offenderNo: offender_ids).
            merge(Movement.by_type(types)).flat_map(&:movements)
      end
    end
  end
end
