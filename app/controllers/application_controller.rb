class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def warn_user
     unless current_user
      redirect_to root_url, alert: 'You must be logged in to access this page!'
    end
  end

  helper_method :current_user, :warn_user
end
