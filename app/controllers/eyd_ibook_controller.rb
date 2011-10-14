class EydIbookController < ApplicationController
  before_filter :authorize
  layout 'admin'

  def index
    @total_ibooks = EydIbook.paginate_by_sql ["select ibook.* from eyd_ibooks ibook where ibook.user_id=#{session[:user_id]} order by ibook.updated_at desc"], :page => params[:page], :per_page=>20 
  end

  def show
    @eydIbook = EydIbook.find(params[:id])
  end

  def new
  end

  def upload
    newparams = coerce(params)
    @eydIbook = EydIbook.new(newparams[:upload])
    if @eydIbook.title != nil
      @eydIbook.tag_list = @eydIbook.title
    end
    if @eydIbook.save
      flash[:notice] = "ibook successfully created"
      respond_to do |format|
        format.html {redirect_to @eydIbook}
        format.json {render :json => {:result => 'success', :upload => ibook_show_path(@eydIbook)}}
      end
    else
      render :action => 'ibook_upload'
    end 
  end

  def destroy
    if params[:ibook_ids] != nil
      params[:ibook_ids].each do |ibook_id|
        @eyd_ibook = EydIbook.find(ibook_id)
        @eyd_ibook.destroy
      end
    end
    respond_to do |format|
      format.html {redirect_to(ibook_index_path)}
      format.xml {head ok}
    end
  end

  private 
  def coerce(params)
    if params[:upload].nil? 
      h = Hash.new 
      h[:upload] = Hash.new 
      h[:upload][:title] = params[:title] 
      h[:upload][:image_url] = params[:image_url] 
      h[:upload][:desc] = params[:desc] 
      h[:upload][:user_id] = session[:user_id]
      h[:upload][:ibook] = params[:Filedata] 
      h[:upload][:ibook].content_type = MIME::Types.type_for(h[:upload][:ibook].original_filename).to_s
      h
    else 
      params
    end 
  end

end
