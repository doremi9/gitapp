class PullRequestsController < ApplicationController
  before_action :require_login
  
  def index
    @pulls        = orgs_pull_requests
    @active_pulls = orgs_pull_requests.active
    @closed_pulls = orgs_pull_requests.closed
  end

  def show
  end

  def all
    @pulls = repo_pull_requests
    @active_pulls = repo_pull_requests.active
    @closed_pulls = repo_pull_requests.closed
  end

  private

    def orgs_pull_requests
      current_user.organizations
                  .find(params[:organization_id])
                  .repositories.find(params[:repository_id])
                  .pull_requests
    end

    def repo_pull_requests
      current_user.repositories.find(params[:id]).pull_requests
    end

end