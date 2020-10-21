# frozen_string_literal: true

Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  root "admin/dashboard#index"

  namespace :nomis do
    namespace :api do
      get "/locations/description/:prison_id/inmates" => "offenders#index"
      get "/prisoners/:offender_no" => "offenders#show"
      post "/offender-sentences/bookings" => "bookings#index"
      get "/users/:username" => "users#show"
      get "/staff/:staffId/emails" => "users#emails"
      get "/staff/:staffId/caseloads" => "users#caseloads"
      get "/staff/roles/:prison_id/role/POM" => "users#roles"
      post "/movements/offenders" => "movements#index"
    end
  end
end
