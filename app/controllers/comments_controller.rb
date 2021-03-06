class CommentsController < ApplicationController
  before_action :require_login
  def index
    @comments = current_user.repositories
                            .find(params[:repository_id])
                            .pull_requests.find(params[:pull_request_id])
                            .comments
  end
end