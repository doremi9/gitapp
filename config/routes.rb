Rails.application.routes.draw do
  root 'github#index'
  resources :organizations, only: [:index, :show]
  resources :repositories,  only: [:index, :show]
  get '/auth/:provider/callback', to: 'github#callback'
  get '/auth/failure', to: 'github#failure'
  delete 'sign_out',   to: 'github#destroy', as: 'sign_out'
  get '/fetch',        to: 'github#fetch',   as: 'fetch_github_data'
end
