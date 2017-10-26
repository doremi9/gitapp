Rails.application.routes.draw do
  root 'home#index'
  get 'profile', to: 'home#profile', as: 'profile'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'
  delete 'sign_out', to: 'sessions#destroy', as: 'sign_out'
end
