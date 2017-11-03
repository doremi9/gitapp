class GithubController < ApplicationController

  def index
  end
  
  def callback
    auth = request.env["omniauth.auth"]
    session[:omniauth] = auth.except('extra')
    user = User.sign_in_from_omniauth(auth)
    session[:user_id] = user.id
    client = GithubService.new(current_user, ENV['GITHUB_ACCESS_TOKEN'])
    client.save_organizations
    client.save_repositories
    client.pull_requests
    redirect_to '/'
  end

  def destroy
    session[:user_id]  = nil
    session[:omniauth] = nil
    redirect_to root_url
  end

  def failure
    redirect_to root_url, alert: 'Authentication error: #{params[:message].humanize}'
  end

end
