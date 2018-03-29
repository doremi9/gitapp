class GithubController < ApplicationController

  def index
  end

  def fetch
    GithubService.new(current_user, ENV['GITHUB_ACCESS_TOKEN']).call
    redirect_to root_url
  end
  
  def destroy
    session[:user_id]  = nil
    session[:omniauth] = nil
    flash[:success] = 'You have successfully signed out!'
    redirect_to root_url
  end
end
