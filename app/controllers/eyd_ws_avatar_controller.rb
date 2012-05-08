class EydWsAvatarController < ApplicationController
  skip_before_filter :authorize

  def avatars
    @avatars = EydAvatar.where(:user_id=>1).order('updated_at desc').limit(280)
    respond_to do |format|
      format.xml  { render :xml => @avatars}
      format.json { render :json => @avatars}
    end
  end
end
