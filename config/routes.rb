Rails.application.routes.draw do
  root 'github#index'
  resources :organizations, only: [:show] do
    resources :repositories,  only: [:show] do 
      resources :pull_requests, only: [:index, :show] do
        resources :comments, only: [:index]
      end
    end
  end
  get '/auth/:provider/callback', to: 'github#callback'
  delete 'sign_out',   to: 'github#destroy', as: 'sign_out'
  get '/fetch',        to: 'github#fetch',   as: 'fetch_github_data'
  # post '/webhooks',    to: 'github#webhooks',as: 'webhooks'
  post '/:gh_webhook_token/webhook', to: 'github#webhook', as: 'webhook'
  get '/settings', to: 'users#settings', as: 'settings'
end

