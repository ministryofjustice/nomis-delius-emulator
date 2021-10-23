# frozen_string_literal: true

module PrisonApi
  module Api
    class MovementsController < ApplicationController
      respond_to :json

      # This is a POST action but is just a hidden GET really
      skip_before_action :verify_authenticity_token, only: :index

      def index
        raw = request.query_string.split("&")
        types = raw.select { |h| h.starts_with?("movementTypes=") }.map { |t| t.split("=").second }
        offender_ids = JSON.parse(request.body.string)
        @movements = Movement.includes(:offender, :to_prison, :from_prison)
          .by_type(types).joins(:offender).merge(Offender.by_offender_no(offender_ids))
      end

      def by_date
        from_date = Date.parse(params[:fromDateTime])
        to_date = Date.parse(params[:movementDate])
        logger.debug("By date from #{from_date} to #{to_date}")
        @movements = Movement.where("date > ? and date <= ?", from_date, to_date)
      end
    end
  end
end
