# frozen_string_literal: true

module Nomis
  module Api
    class MovementsController < ApplicationController
      respond_to :json

      # This is a POST action but is just a hidden GET really
      skip_before_action :verify_authenticity_token, only: :index

      def index
        if request.query_string.blank?
          types = params[:movementTypes]
        else
          raw = request.query_string.split('&')
          types = raw.select { |h| h.starts_with?('movementTypes=')}.map { |t| t.split('=').second }
        end
        offender_ids = JSON.parse(request.body.string)
        @movements = Offender.includes(:movements).joins(:movements).
            where(offenderNo: offender_ids).
            merge(Movement.by_type(types)).flat_map(&:movements)
      end

      def by_date
        from_date = Date.parse(params[:fromDateTime])
        to_date = Date.parse(params[:movementDate])
        logger.debug("By date from #{from_date} to #{to_date}")
        @movements = Movement.where('date > ? and date <= ?', from_date, to_date)
      end
    end
  end
end
