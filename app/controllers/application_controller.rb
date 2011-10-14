class ApplicationController < ActionController::Base
  before_filter :authorize
  protect_from_forgery

  protected
  def authorize
    unless EydUser.find_by_id(session[:user_id])
      redirect_to login_url, :notice => "Please log in"
    end
  end
end
