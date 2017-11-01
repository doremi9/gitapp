class OrganizationsController < ApplicationController
  # make sure user is logged in before accessing this page
  # before_action :login_user
  
  def index
    @organizations = Organization.includes(:user).all
  end

  def show
    @organization = Organization.find(params[:id])
  end
end