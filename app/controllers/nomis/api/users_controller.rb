# frozen_string_literal: true

module Nomis
  module Api
    class UsersController < ApplicationController
      respond_to :json

      def show
        @user = User.find_by(username: params[:username])
        @caseload = Struct.new(:activeCaseLoadId).new(Prison.first.code)
      end

      def emails
        @user = User.find_by(staffId: params[:staffId])
      end

      def caseloads
        @caseloads = Prison.all
      end

      def roles
        @users = User.all
      end
    end
  end
end
