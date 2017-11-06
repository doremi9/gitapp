class RepositoriesController < ApplicationController
  before_action :get_current_user

  def index
    @repos = @user.repositories
  end

  def show
    @repo = @user.repositories.find(params[:id])
  end

end