module Nomis
  module Api
    class OffendersController < ApplicationController
      respond_to :json

      def index
        offset = request.headers['Page-Offset']
        limit = request.headers['Page-Limit']
        prison = Prison.find_by(code: params[:prison_id])
        @offenders = prison.offenders.offset(offset).limit(limit)
      end
    end
  end
end
