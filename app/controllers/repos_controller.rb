class ReposController < ApplicationController
  def index
    @repos = Repo.includes(:user).all
  end

  def show
    @repo = Repo.find(params[:id]).pull_requests
  end
end