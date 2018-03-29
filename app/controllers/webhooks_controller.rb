class WebhooksController < ApplicationController
  
  def webhook
    WebhookService.new.call(params)
  rescue WebhookService::UserNotFound
    Rails.logger.info("Received webhook for non existing user: #{params[:gh_webhook_token]}")
  end

  def callback
    auth = request.env["omniauth.auth"]
    user = UserService.new.call(auth)
    session[:user_id] = user.id
    flash[:success] = "You have successfully signed in!"
    redirect_to root_url
  end
end

