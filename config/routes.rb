Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'api/categories#index'

  mount Rswag::Ui::Engine => '/api/docs'
  mount Rswag::Api::Engine => '/api/docs'

  namespace :api, defaults: { format: 'json' } do
    resources :categories, only: %i[index show]

    namespace :admin do
      resources :categories
      resources :custom_fields
    end
  end
end
