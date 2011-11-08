class EydfHomeController < ApplicationController
  skip_before_filter :authorize
  before_filter :fetch_categories, :fetch_archivals, :except=>[:gallery_list, :tag_gallery_list]
  before_filter :build_comment, :only=> [:show_blog]
  #caches_page :gallery_list,:tag_gallery_list

  def fetch_categories
    session[:userId]=1
    unless read_fragment('category_fragment'+session[:userId].to_s)
      @constants = EydConstant.where(:user_id =>1).order('updated_at desc')
    end
  end

  def fetch_archivals
    unless read_fragment('archival_fragment'+session[:userId].to_s)
      @archivals = EydBlog.fetch_archival_list(1)
    end
  end

  def index
    #EydMailer.delay.mail_new_posts
    #EydMailer.mail_new_posts.deliver
    @total_blogs = EydBlog.fetch_blogs(1,params[:page],false)
  end
end
