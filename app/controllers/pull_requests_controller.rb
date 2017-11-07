class PullRequestsController < ApplicationController
  def index
    @pulls        = get_pull_requests
    @active_pulls = get_pull_requests.active
    @closed_pulls = get_pull_requests.closed
  end

  def show
  end

  private

    def get_pull_requests
      current_user.organizations
                  .find(params[:organization_id])
                  .repositories.find(params[:repository_id])
                  .pull_requests
    end

end