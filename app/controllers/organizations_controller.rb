class OrganizationsController < ApplicationController
  before_action :require_login

  def show
    @organization = current_user.organizations.find(params[:id])
  end

end