class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_url, notice: exception.message
    #redirect_to root_url,:flash => { :error => "Insufficient rights!", :color => "invalid" }
  end

  protected
  #def authenticate_user
  
  # def current_user
  # 	unless session[:user_id]
  # 		redirect_to(:controller => 'sessions', :action => 'login')
  # 		return false
  # 	else
  #     # set current_user by the current user object
  #     @current_user = User.find session[:user_id] 
  # 		return true
  # 	end
  # end

  def current_user
      return unless session[:user_id]
      @current_user ||= User.find(session[:user_id])
  end

  #This method for prevent user to access Signup & Login Page without logout
  def save_login_state
    if session[:user_id]
            redirect_to(:controller => 'sessions', :action => 'home')
      return false
    else
      return true
    end
  end
end
