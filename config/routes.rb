Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  root 'admin/dashboard#index'

  namespace :api do
    get "/locations/description/:prison_id/inmates" => 'offenders#index'
    post '/offender-sentences/bookings' => 'bookings#index'
  end
end
