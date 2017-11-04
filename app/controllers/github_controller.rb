class GithubController < ApplicationController

  def index
  end

  def fetch
    GithubService.new(current_user, ENV['GITHUB_ACCESS_TOKEN']).call
    redirect_to root_url
  end
  
  def callback
    auth = request.env["omniauth.auth"]
    session[:omniauth] = auth.except('extra')
    user = User.sign_in_from_omniauth(auth)
    session[:user_id] = user.id
    redirect_to fetch_github_data_path
  end

  def destroy
    session[:user_id]  = nil
    session[:omniauth] = nil
    redirect_to root_url
  end

  def failure
    redirect_to root_url, alert: 'Authentication error: #{params[:message].humanize}'
  end

  def webhooks
    puts "webhook received!"
  end

end
