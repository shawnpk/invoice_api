Rails.application.routes.draw do
  resources :users

  namespace :v1 do
    resources :contacts
    resources :sessions, only: %i[create destroy]
  end
end
