Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v0 do
      get "/markets/search", to: "markets#search"
      get "/markets/:id/nearest_atms", to: "markets#nearest_atms"
      resources :markets, only: [:index, :show] do
        resources :vendors, only: [:index], controller: :market_vendors
      end
      get "/vendors/multiple_states", to: "vendors#multiple_states"
      get "/vendors/popular_states", to: "vendors#popular_states"
      resources :vendors, only: [:show, :create, :update, :destroy]
      resource :market_vendors, only: [:create, :destroy]
    end
  end
end
