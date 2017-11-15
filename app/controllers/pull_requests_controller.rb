class PullRequestsController < ApplicationController
  before_action :require_login
  
  def index
    @pulls = current_user.organizations
                  .find(params[:organization_id])
                  .repositories.find(params[:repository_id])
                  .pull_requests
  end

  def show
  end

end