# frozen_string_literal: true

Rails.application.routes.draw do
  get "staff/show"
  get "users/show"
  ActiveAdmin.routes(self)

  root "admin/dashboard#index"

  namespace :nomis do
    namespace :api do
      get "/locations/description/:prison_id/inmates" => "offenders#index"
      post "/offender-sentences/bookings" => "bookings#index"
      get "/users/:username" => "users#show"
      get "/staff/:staffId/emails" => "users#emails"
      get "/staff/:staffId/caseloads" => "users#caseloads"
      get "/staff/roles/:prison_id/role/POM" => "users#roles"
    end
  end
end
