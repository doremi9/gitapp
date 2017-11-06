class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def get_current_user
    @user = current_user
  end

  helper_method :current_user, :get_current_user
end
