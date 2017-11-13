class GithubController < ApplicationController

  def index
    if current_user
      @user_repos = current_user.repositories
      @user_orgs  = current_user.organizations
    end
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

  def webhooks
    if params[:github][:action] == "opened"
      payload = PayloadParserService.new.parse(params)
      WebhookService.new.handle_webhook(payload)
    end
  end
end

