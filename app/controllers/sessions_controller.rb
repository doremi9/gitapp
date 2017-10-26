class SessionsController < ApplicationController
  
  def create
    Rails.logger.debug "-----Params-------------------"
    puts params
    Rails.logger.debug "-----Params-------------------"
    auth = request.env["omniauth.auth"]
    Rails.logger.debug "-----OAuth-------------------"
    puts auth
    Rails.logger.debug "-----OAuth-------------------"
    session[:omniauth] = auth.except('extra')
    user = User.sign_in_from_omniauth(auth)
    session[:user_id] = user.id
    redirect_to profile_path
  end

  def destroy
    session[:user_id]  = nil
    session[:omniauth] = nil
    redirect_to root_url
  end

  def failure
    redirect_to root_url, alert: 'Authentication error: #{params[:message].humanize}'
  end

end
