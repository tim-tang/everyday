class EydLoginController < ApplicationController
  skip_before_filter :authorize
  layout 'login'

  def login
  end

  def authentication
    if user = EydUser.authenticate(params[:name], params[:password])
      session[:user_id] = user.id
      session[:user_name] = user.name
      redirect_to avatar_index_url
    else
      redirect_to login_url, :alert => "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, :notice => "Logged out"
  end

end
