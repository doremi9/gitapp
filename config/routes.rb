Rails.application.routes.draw do
  root 'github#index'
  resources :organizations do
    resources :repositories,  only: [:index, :show] do 
      resources :pull_requests, only: [:index, :show] do
        resources :comments, only: [:index]
      end
    end
  end
  get '/repositories', to: 'repositories#all'
  get '/auth/:provider/callback', to: 'github#callback'
  get '/auth/failure', to: 'github#failure'
  delete 'sign_out',   to: 'github#destroy', as: 'sign_out'
  get '/fetch',        to: 'github#fetch',   as: 'fetch_github_data'
  post '/webhooks',    to: 'github#webhooks',as: 'webhooks'
end
