class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login  
  helper_method :current_user
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private
    def require_login
      return redirect_to root_path unless session[:user_id]
    end

end
