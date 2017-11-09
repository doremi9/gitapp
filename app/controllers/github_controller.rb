class GithubController < ApplicationController

  def index
    if current_user
      @user_repos = current_user.repositories
      @user_orgs  = current_user.organizations
    end
  end

  def fetch
    GithubService.new(current_user, ENV['GITHUB_ACCESS_TOKEN']).call
    flash[:success] = "You have successfully signed in!"
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
    flash[:success] = 'You have successfully signed out!'
    redirect_to root_url
  end

  def webhooks
    Rails.logger.debug '---------current user------'
    puts user_repos
    Rails.logger.debug '---------current user------'
    # create_pull_request_from(response_params)
    # create_comment_for_pull_request
  end

  private

    def create_pull_request_from(parameters)
      user_repos.pull_requests.find_or_create_by(parameters)
    end

    def response_params
      {
        pr_id:        params[:pull_request][:id],
        number:       params[:pull_request][:number],
        state:        params[:pull_request][:state],
        title:        params[:pull_request][:title],
        body:         params[:pull_request][:body],
        author:       params[:pull_request][:user][:login],
        repository:   params[:repository][:full_name],
        organization: params[:organization][:login]
      }
    end

    def user_repos
      Rails.logger.debug '---------current user------'
      puts current_user#.find_by(name: response_params[:organization])
                  #.repositories.find_by(name: response_params[:repository])
      Rails.logger.debug '---------current user------'
    end

    # def create_comment_for_pull_request
    #   user_repos.pull_requests.find_by(pr_id: response_params[:pr_id])
    #             .comments.create(
    #               text: "Siema, ziomal! Wszystko jest OK!",
    #               gif_url: gif_url
    #               )
    # end

    def gif_url
      Giphy.random('excited').image_url.to_s
    end
  end
