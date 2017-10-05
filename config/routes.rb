Rails.application.routes.draw do
  resources :vehicles do
    collection do
      get 'speed'
    end
  end
  resources :positions do
    collection do
      get 'marker'
    end
  end
  root to: "positions#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
