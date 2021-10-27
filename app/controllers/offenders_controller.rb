# frozen_string_literal: true

class OffendersController < ApplicationController
  respond_to :json

  def keyworker
    offender = Offender.find_by!(offenderNo: params[:offender_no])
    @keyworker = offender.keyworker
    raise ActiveRecord::RecordNotFound unless @keyworker
  end
end
