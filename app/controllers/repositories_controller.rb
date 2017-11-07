class RepositoriesController < ApplicationController
  before_action :warn_user
  
  def index
    @repos = current_user.organizations.find(params[:organization_id]).repositories
  end

  def show
    @repo = current_user.organizations.find(params[:organization_id]).repositories.find(params[:id])
  end

  def all
    @repos = current_user.repositories
  end

end