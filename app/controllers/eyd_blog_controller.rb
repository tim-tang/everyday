class EydBlogController < ApplicationController
  before_filter :authorize
  before_filter :fetch_blog, :only => [:edit, :update]
  before_filter :build_blog, :only =>[:new, :create]
  before_filter :fetch_categories, :only =>[:new, :edit]
  layout 'admin'
  #cache_sweeper :eyd_blog_sweeper, :only=>[:create]

  def index
    @total_blogs = EydBlog.fetch_blogs(session[:user_id], params[:page],false)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @total_blogs}
      format.json { render :json => @total_blogs}
    end
  end

  def draft
    @total_blogs = EydBlog.fetch_admin_blogs(session[:user_id], params[:page],true)
  end

  def new
  end

  def create
    blog_val_setter(@eyd_blog, params)
    respond_to do |format|
      if @eyd_blog.save
        if @eyd_blog.is_draft==true
          format.html { redirect_to(blog_draft_path, :notice => 'Draft blog was successfully created.') }
        else
          expire_cache
          format.html { redirect_to(blog_index_path, :notice => 'Blog was successfully created.') }
        end
        format.xml  { render :xml => @eyd_blog, :status => :created, :location => @eyd_blog }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @eyd_blog.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @eyd_blog.blog_tags = @eyd_blog.tag_list
  end

  def update
    respond_to do |format|
      if @eyd_blog.update_attributes(params[:eyd_blog])
        #expire cached_comment for postmeta
        Rails.cache.delete("#{@eyd_blog.id}_categories")
        format.html { redirect_to(blog_index_path, :notice => 'Blog was successfully updated.') }
        format.xml  { render :xml => @eyd_blog, :status => :updated, :location => @eyd_blog }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @eyd_blog.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    if params[:blog_ids] != nil
      params[:blog_ids].each do |blog_id|
        @eyd_blog = EydBlog.find(blog_id)
        @eyd_blog.destroy
        expire_cache
        #expire cached_comment for postmeta
        Rails.cache.delete("#{@eyd_blog.id}_categories")
      end
    end
    respond_to do |format|
      format.html {redirect_to(blog_index_path)}
      format.xml {head ok}
    end
  end

  protected
  def build_blog
    @eyd_blog = EydBlog.new
  end

  def fetch_blog
    @eyd_blog = EydBlog.find(params[:id])
  end

  def fetch_categories
    @constants = EydConstant.where(:user_id => session[:user_id])
  end

  private
  def blog_val_setter(eyd_blog, params)
    eyd_blog.title = params[:eyd_blog][:title]
    eyd_blog.content = params[:eyd_blog][:content]
    eyd_blog.constant_id = params[:eyd_blog][:constant_id]
    eyd_blog.video_url = params[:eyd_blog][:video_url]
    eyd_blog.is_draft = params[:eyd_blog][:is_draft]
    eyd_blog.blog_tags = params[:eyd_blog][:blog_tags]
    eyd_blog.tag_list=@eyd_blog.blog_tags
    eyd_blog.user_id = session[:user_id]
    eyd_blog.author = session[:user_name]
  end

  def expire_cache
    expire_fragment 'category_fragment'+session[:user_id].to_s
    expire_fragment 'tag_fragment'
    expire_fragment 'archival_fragment'+session[:user_id].to_s
  end

end
