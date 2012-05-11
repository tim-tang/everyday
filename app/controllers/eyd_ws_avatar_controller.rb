class EydWsAvatarController < ApplicationController
  skip_before_filter :authorize

  def avatars
    @avatars = EydAvatar.where('user_id =? and created_at < ?', 1, params[:id]).order('created_at desc').limit(15)
    respond_to do |format|
      format.xml  { render :xml => @avatars}
      format.json { render :json => @avatars}
    end
  end
end
