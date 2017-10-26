class HomeController < ApplicationController
  def index
    
  end

  def profile
    if !current_user
      redirect_to root_path
    end
  end
end
