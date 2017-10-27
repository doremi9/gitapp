class GithubController < ApplicationController

  def index
  end
  
  def callback
    auth = request.env["omniauth.auth"]
    session[:omniauth] = auth.except('extra')
    user = User.sign_in_from_omniauth(auth)
    session[:user_id] = user.id
    github = Github.new do |config| 
      config.basic_auth = "#{auth.extra.login}:#{auth.credentials.token}"
      # add extra config here
    end
    @repos = github.repos.list
    unless @repos.nil?
      @repos.each do |repo|
        current_user.repos.find_or_create_by(name: repo["name"], url: repo["html_url"], pull_requests_url: repo["pulls_url"])
      end
    end
    redirect_to profile_path
  end

  def profile
    redirect_to root_path unless current_user
    @repos = current_user.repos
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
