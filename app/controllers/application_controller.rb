class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate
  	tokenGoogle = request.headers['tokenGoogle']
  	if(tokenGoogle)
  	  @user = User.where(oauth_token: tokenGoogle).first
  	else
  	  @user = current_user
  	end
  end
end
