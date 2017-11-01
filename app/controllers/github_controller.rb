class GithubController < ApplicationController

  def index
  end
  
  def callback
    auth = request.env["omniauth.auth"]
    session[:omniauth] = auth.except('extra')
    user = User.sign_in_from_omniauth(auth)
    session[:user_id] = user.id
    get_from_github
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

  private

    def get_from_github
      client = Octokit::Client.new(:access_token => ENV['GITHUB_ACCESS_TOKEN'])
      client.organizations.each { |org| current_user.organizations.find_or_create_by(
        name: org[:login],
        avatar_url: org[:avatar_url],
        description: org[:description]
        )
      Organization.all.each do |organization|
        client.organization_repositories(org[:login]).each do |repo|
          organization.repositories.find_or_create_by(name: repo.full_name)
        end
      end
      }
    end
end
