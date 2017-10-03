Rails.application.routes.draw do
  resources :positions do
    collection do
      get 'test'
    end
  end
  root to: "positions#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
