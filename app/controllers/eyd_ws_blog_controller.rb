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
    @prev_next_blogs = EydBlog.find_by_sql("SELECT * FROM eyd_blogs WHERE user_id = 1 and id IN (SELECT CASE WHEN SIGN(id - #{params[:id]}) > 0 THEN MIN(id) WHEN SIGN(id - #{params[:id]}) < 0 THEN MAX(id) END AS id FROM eyd_blogs WHERE id <> #{params[:id]} GROUP BY SIGN(id - #{params[:id]}) ORDER BY SIGN(id - #{params[:id]})) ORDER BY id ASC")
    if @prev_next_blogs.size >1
      @next_blog = @prev_next_blogs[0]
    else
      if @prev_next_blogs.size ==1
        if @prev_next_blogs[0].id < params[:id].to_i
          @next_blog = @prev_next_blogs[0]
        end
      end
    end
    respond_to do |format|
      format.xml  { render :xml => @next_blog}
      format.json { render :json => @next_blog}
    end
  end

  def sync_count
    @blog = EydBlog.find(params[:id])
    @blog.view_count+=1
    @blog.update_attribute("view_count",@blog.view_count)
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
