Rails.application.routes.draw do
  root 'pages#index'
  resource :session, only: %i[new create]
  get 'session' => 'sessions#destroy'
  resources :users, only: %i[new create]
  resources :reports
end
