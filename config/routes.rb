require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  scope :backend do
    authenticate :admin_user do
      mount Rswag::Ui::Engine => '/docs'
      mount Rswag::Api::Engine => '/docs'
      mount PgHero::Engine, at: '/pghero'
      mount Sidekiq::Web, at: '/sidekiq'
    end
  end

  root 'welcome#index'

  namespace :api, defaults: { format: 'json' } do
    resources :categories, only: %i[index show] do
      get :breadcrumbs

      collection do
        get :ids
      end

      resources :listings, only: %i[index show]
      resources :subcategories, only: %i[index show], controller: 'categories'
    end

    resources :listings, only: %i[create update destroy] do
      collection do
        get :recommended
      end
    end

    post '/sign_up', controller: 'registration', action: 'create'
    post '/sign_in', controller: 'authentication', action: 'create'
    post '/tokens', controller: 'tokens', action: 'create'
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
