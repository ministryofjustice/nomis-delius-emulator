# frozen_string_literal: true

module Nomis
  module Api
    class MovementsController < ApplicationController
      respond_to :json

      # This is a POST action but is just a hidden GET really
      skip_before_action :verify_authenticity_token, only: :index

      def index
        offender_ids = JSON.parse(request.body.string)
        if request.query_string.blank?
          types = params[:movementTypes]
        else
          raw = request.query_string.split('&')
          types = raw.select { |h| h.starts_with?('movementTypes=')}.map { |t| t.split('=').second }
        end
        @movements = Offender.includes(:movements).joins(:movements).
            where(offenderNo: offender_ids).
            merge(Movement.by_type(types)).flat_map(&:movements)
        # logger.debug "Query String #{request.query_string}"
      end

      def by_date
        fromDateTime = Date.parse(params[:fromDateTime])
        toDateTime = Date.parse(params[:movementDate])
        @movements = Movement.where('date > ? and date <= ?', fromDateTime, toDateTime)
      end
    end
  end
end
