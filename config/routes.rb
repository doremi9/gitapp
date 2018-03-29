Rails.application.routes.draw do
  root 'github#index'
  resources :organizations, only: [:show] do
    resources :repositories,  only: [:show] do 
      resources :pull_requests, only: [:index, :show] do
        resources :comments, only: [:index]
      end
    end
  end
  get '/auth/:provider/callback', to: 'webhooks#callback'
  delete 'sign_out',   to: 'github#destroy', as: 'sign_out'
  get '/fetch',        to: 'github#fetch',   as: 'fetch_github_data'
  post '/:gh_webhook_token/webhook', to: 'webhooks#webhook', as: 'webhook'
  get '/settings', to: 'users#settings', as: 'settings'
end

