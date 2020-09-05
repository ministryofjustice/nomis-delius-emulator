Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  root 'admin/dashboard#index'

  get "/api/locations/description/:prison_id/inmates" => 'offenders#index'
  post '/api/offender-sentences/bookings' => 'bookings#index'
end
