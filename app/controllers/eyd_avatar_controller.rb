class EydAvatarController < ApplicationController
  before_filter :authorize
  layout 'admin'

  def index
    @total_avatars = EydAvatar.paginate_by_sql ["select ava.* from eyd_avatars ava where ava.user_id=#{session[:user_id]} order by ava.updated_at desc"], :page => params[:page], :per_page=>20 
  end

  def new
    @eydAvatar = EydAvatar.new
  end

  def show 
    @eydAvatar = EydAvatar.find(params[:id])
  end

  def upload
    newparams = coerce(params)
    @eydAvatar = EydAvatar.new(newparams[:upload])
    if @eydAvatar.title != nil
      @eydAvatar.tag_list = @eydAvatar.title
    end
    if @eydAvatar.save
      # expire gallery list cache page
      #expire_page(:controller => 'eydf_home', :action=>'gallery_list')
      #@eydAvatar.tag_list.each do |tag|
      #  expire_page(:controller => 'eydf_home', :action=>'tag_gallery_list', :id=> tag)
      #end

      flash[:notice] = "Avatar successfully created"
      respond_to do |format|
        format.html {redirect_to @eydAvatar}
        format.json {render :json => {:result => 'success', :upload => avatar_show_path(@eydAvatar)}}
      end
    else
      render :action => 'avatar_upload'
    end
  end

  def destroy
    if params[:avatar_ids] != nil
      params[:avatar_ids].each do |avatar_id|
        @eyd_avatar = EydAvatar.find(avatar_id)
        # expire gallery list cache page
        #expire_page(:controller => 'eydf_home', :action=>'gallery_list')
        #@eyd_avatar.tag_list.each do |tag|
        #  expire_page(:controller => 'eydf_home', :action=>'tag_gallery_list', :id=> tag)
        #end
        @eyd_avatar.destroy
      end
    end
    respond_to do |format|
      format.html {redirect_to(avatar_index_url)}
      format.xml {head ok}
    end
  end

  private 
  def coerce(params)
    if params[:upload].nil? 
      h = Hash.new 
      h[:upload] = Hash.new 
      h[:upload][:title] = params[:title] 
      h[:upload][:desc] = params[:desc] 
      h[:upload][:constant_id] = 1
      h[:upload][:user_id] = session[:user_id]
      h[:upload][:avatar] = params[:Filedata] 
      h[:upload][:avatar].content_type = MIME::Types.type_for(h[:upload][:avatar].original_filename).to_s
      h
    else 
      params
    end 
  end

end
