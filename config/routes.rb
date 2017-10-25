
Rails.application.routes.draw do
  resources :services
  # resources :maintenances
  resources :tyres

  resources :maintenances do
    collection do
      get 'reset'
    end
  end

  resources :vehicles do
    collection do
      get 'speed'
    end
  end

  resources :positions do
    collection do
      get 'marker'
      get 'routes'
    end
  end
  root to: "static_pages#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
