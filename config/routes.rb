Rails.application.routes.draw do
  resources :teams
  
  get "/schedule", to: "teams#schedule"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "teams#index"
end
