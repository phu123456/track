Rails.application.routes.draw do
  resources :positions
  root to: "positions#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
