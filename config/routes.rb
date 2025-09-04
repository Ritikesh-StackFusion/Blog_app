Rails.application.routes.draw do
  resources :posts
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check
  root "posts#index"

  namespace :api do
    namespace :v1 do
      resources :posts
    end
  end

end
