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
    create_comment_for_pull_request
  end

  private

    def create_comment_for_pull_request
      Organization.find_by(name: params[:organization][:login])
                  .repositories.find_by(name: params[:repository][:full_name])
                  .pull_requests.find_by(pr_id: params[:pull_request][:id])
                  .comments.create(text: "Siema, ziomal! Wszystko jest OK!", gif_url: gif_url)
    end

    def gif_url
      Giphy.random('excited').image_url.to_s
    end
  end
