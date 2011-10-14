class EydUserController < ApplicationController

  def create
    @user = EydUser.new(params[:user])
    @user.save
  end

end
