Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  get "/elite2api/api/locations/description/:prison_id/inmates" => 'offenders#index'
  post '/elite2api/api/offender-sentences/bookings' => 'bookings#index'
end
