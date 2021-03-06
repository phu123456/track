Rails.application.routes.draw do
  resources :histories
  devise_for :users
  resources :services
  # resources :maintenances
  resources :tyres do
    collection do
      get 'attach'
      get 'dettach'
      get 'destroyed'
      get 'current'
    end
  end
  resources :maintenances do
    collection do
      get 'reset'
    end
  end

  resources :vehicles do
    collection do
      get 'speed'
      get 'category'
    end
  end

  resources :positions do
    collection do
      get 'marker'
      get 'routes'
      get 'info'
    end
  end
  root to: "static_pages#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
