Rails.application.routes.draw do
  root 'reports#index'
  resources :reports
  resources :users
end
