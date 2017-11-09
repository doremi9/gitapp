class RepositoriesController < ApplicationController
  before_action :require_login
  
  def index
    @repos = current_user.organizations.find(params[:organization_id]).repositories
  end

  def show
    @repo = current_user.organizations.find(params[:organization_id]).repositories.find(params[:id])
  end

end