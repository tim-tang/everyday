class TechWsBlogController < ApplicationController
  skip_before_filter :authorize

  def blogs
    @total_blogs=EydBlog.tech_ws_blogs(2,params[:id],false)
    respond_to do |format|
      format.xml  { render :xml => @total_blogs}
      format.json { render :json => @total_blogs}
    end
  end

  def blog
    @blog = EydBlog.find(params[:id])
    respond_to do |format|
      format.xml  { render :xml => @blog}
      format.json { render :json => @blog}
    end
  end

  def category
    @total_blogs = EydBlog.tech_ws_category(2,params[:id],params[:page])
    respond_to do |format|
      format.xml  { render :xml => @total_blogs}
      format.json { render :json => @total_blogs}
    end
  end

  def size
    @total_blogs = EydBlog.tech_ws_blog_size(2,params[:id])
    respond_to do |format|
      format.xml  { render :xml => @total_blogs}
      format.json { render :json => @total_blogs}
    end
  end

  def sync_count
    EydBlog.ws_sync_count(params[:id])
    respond_to do |format|
      format.xml  { render :xml => "successfully updated."}
      format.json { render :json => "successfully updated."}
    end
  end
end
