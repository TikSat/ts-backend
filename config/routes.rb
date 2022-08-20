Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'api/categories#index'

  mount Rswag::Ui::Engine => '/api/docs'
  mount Rswag::Api::Engine => '/api/docs'

  namespace :api, defaults: { format: 'json' } do
    resources :categories, only: %i[index show] do
      resources :listings, only: %i[index show]
      resources :subcategories, only: [:index], controller: 'categories', on: :member
    end

    resources :listings, only: %i[create update destroy] do
      collection do
        get :recommended
      end
    end

    post '/sign_up', controller: 'registration', action: 'create'
    get '/me', to: 'users#show'

    resources :profiles do
      member do
        post 'toggle'
      end
    end

    namespace :admin do
      resources :categories
      resources :custom_fields
    end
  end
end
