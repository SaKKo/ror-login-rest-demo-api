Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :user do
        post 'sessions/create'
      end
    end
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
