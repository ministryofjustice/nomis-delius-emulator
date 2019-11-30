Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/elite2api/api/locations/description/:prison_id/inmates" => 'offenders#index'
end
