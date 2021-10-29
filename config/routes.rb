# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  ActiveAdmin.routes(self)

  root "admin/dashboard#index"

  get "/health" => "health#index"

  namespace :prison_api do
    namespace :api do
      post "/offender-assessments/CATEGORY" => "offenders#assessments"

      get "/users/:username" => "users#by_username"
      get "/staff/:staffId" => "users#show"
      get "/staff/:staffId/emails" => "users#emails"
      get "/staff/:staffId/caseloads" => "users#caseloads"
      get "/staff/roles/:prison_id/role/POM" => "users#roles"

      post "/movements/offenders" => "movements#index"
      get "/movements" => "movements#by_date"
    end
  end

  defaults format: :json do
    namespace :search_api, path: "/prison-search" do
      post "/prisoner-search/prisoner-numbers" => "offenders#search_prisoner_numbers"
      get "/prisoner-search/prison/:code" => "offenders#search_prison_id"
    end

    namespace :assessments_api, path: "/assessments-api" do
      get "/offenders/nomisId/:offender_no/assessments/summary" => "offenders#assessments"
    end
  end

  get "/keyworker/key-worker/:prison_id/offender/:offender_no" => "offenders#keyworker"
end
