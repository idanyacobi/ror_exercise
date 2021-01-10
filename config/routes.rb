Rails.application.routes.draw do
  resources :users
  post "/sign_in", to: "users#sign_in"
  post "/sign_out", to: "users#sign_out"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
