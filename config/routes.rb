Rails.application.routes.draw do
  root "splunk_users#index"

  resources :splunk_users, only: [:new, :create] do 
    post :validate_key, on: :collection
  end

  post "stats", to: "stats#index"
end
