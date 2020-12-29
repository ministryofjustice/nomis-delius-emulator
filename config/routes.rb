# frozen_string_literal: true

Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  root "admin/dashboard#index"

  namespace :nomis do
    namespace :api do
      get "/locations/description/:prison_id/inmates" => "offenders#index"
      get "/prisoners/:offender_no" => "offenders#show"
      post "/offender-assessments/CATEGORY" => "offenders#assessments"

      post "/offender-sentences/bookings" => "bookings#index"
      get "/bookings/:id/mainOffence" => "bookings#show"

      get "/users/:username" => "users#by_username"
      get "/staff/:staffId" => "users#show"
      get "/staff/:staffId/emails" => "users#emails"
      get "/staff/:staffId/caseloads" => "users#caseloads"
      get "/staff/roles/:prison_id/role/POM" => "users#roles"

      post "/movements/offenders" => "movements#index"
      get "/movements" => "movements#by_date"
    end
  end

  post "/prison-search/prisoner-search/prisoner-numbers" => "offenders#search"
  get "/keyworker/key-worker/:prison_id/offender/:offender_no" => "offenders#keyworker"
end
