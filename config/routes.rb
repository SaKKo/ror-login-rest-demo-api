Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :user do
        post "sign_in", to: "sessions#create"
        delete "sign_out", to: "sessions#destroy"
        resources :blogs
      end
    end
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
