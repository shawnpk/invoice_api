Rails.application.routes.draw do
  namespace :v1 do
    resources :contacts
    resources :sessions, only: %i[create destroy]
  end
end
