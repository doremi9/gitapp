class RepositoriesController < ApplicationController
  def index
    @repos = Repository.includes(:organization).all
  end

  def show
    @repo = Repository.find(params[:id])
  end
end