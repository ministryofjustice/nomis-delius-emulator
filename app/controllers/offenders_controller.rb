class OffendersController < ApplicationController
  def index
    prison = Prison.find_by(code: params[:prison_id])
    @offenders = prison.offenders
  end
end
