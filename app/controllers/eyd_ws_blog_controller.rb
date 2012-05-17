class EydWsBlogController < ApplicationController
  skip_before_filter :authorize

  def blogs
    @total_blogs = EydBlog.ws_fetch_blogs(1,params[:id],false)
    respond_to do |format|
      format.xml  { render :xml => @total_blogs}
      format.json { render :json => @total_blogs}
    end
  end

  def hot
    @hot_topics = EydBlog.ws_hot_blogs(1)
    respond_to do |format|
      format.xml  { render :xml => @hot_topics}
      format.json { render :json => @hot_topics}
    end
  end

  def category
    @total_blogs = EydBlog.ws_fetch_by_category(1,params[:id], params[:dt])
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

  def next_blog
    @next_blog = EydBlog.ws_next_blog(1,params[:id])
    respond_to do |format|
      format.xml  { render :xml => @next_blog}
      format.json { render :json => @next_blog}
    end
  end

  def sync_count
    EydBlog.ws_sync_count(params[:id])
    respond_to do |format|
      format.xml  { render :xml => "successfully updated."}
      format.json { render :json => "successfully updated."}
    end
  end

  def search
    @search = EydBlog.search do
      fulltext params[:id]
    end
    @total_blogs = @search.results
    respond_to do |format|
      format.xml  { render :xml => @total_blogs}
      format.json { render :json => @total_blogs}
    end
  end


end
