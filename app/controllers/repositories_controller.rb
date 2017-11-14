class RepositoriesController < ApplicationController
  before_action :require_login
  
  def show
    @repo = current_user.repositories.find(params[:id])
  end

end