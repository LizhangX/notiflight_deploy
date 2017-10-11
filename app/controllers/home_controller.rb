class HomeController < ApplicationController
  skip_before_action :require_login
  def show
    if session[:user_id]
      return redirect_to user_path(session[:user_id])
    end
  end
end
