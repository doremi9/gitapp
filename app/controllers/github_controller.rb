class GithubController < ApplicationController

  def index
  end

  def fetch
    GithubService.new(current_user, ENV['GITHUB_ACCESS_TOKEN']).call
    redirect_to root_url
  end
  
  def callback
    auth = request.env["omniauth.auth"]
    user = UserService.new.call(auth)
    session[:user_id] = user.id
    flash[:success] = "You have successfully signed in!"
    redirect_to root_url
  end

  def destroy
    session[:user_id]  = nil
    session[:omniauth] = nil
    flash[:success] = 'You have successfully signed out!'
    redirect_to root_url
  end

  def webhook
    Rails.logger.debug '--------------params------------'
    puts params[:gh_webhook_token]
    Rails.logger.debug '--------------params------------'
    WebhookService.new.call(params)
  rescue WebhookService::UserNotFound
    Rails.logger.info("Received webhook for non existing user: #{params[:gh_webhook_token]}")
  end
end

