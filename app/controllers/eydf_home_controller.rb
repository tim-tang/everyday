class EydfHomeController < ApplicationController
  skip_before_filter :authorize
  before_filter :filter_css_curt
  before_filter :filter_right_fragments
  #caches_page :gallery_list,:tag_gallery_list

  def filter_css_curt
    case params[:action].to_s
    when 'index' 
      fetch_index_curt
    when 'tech_list'
      fetch_tech_curt
    when 'ibook_list'||'tag_ibook_list'
      fetch_ibook_curt
    when 'guest_list'
      fetch_guestbook_curt
    when 'gallery_list'||'tag_gallery_list'
      fetch_gallery_curt
    end
  end

  def filter_right_fragments
    if session[:curt_tech] =="current" || session[:curt_ibook] =="current"
      session[:userId]=2
    else 
      #if(params[:action].to_s=='show_blog')
      #  session[:userId]=2
      #else
        session[:userId]=1
      # end
     end
    fetch_categories
    fetch_cloud_tags
    fetch_comments
    fetch_hottopics
    fetch_archivals
  end

  def fetch_categories
    unless read_fragment('category_fragment'+session[:userId].to_s)
      @constants = EydConstant.find_by_sql("select constant.* from eyd_constants constant where constant.user_id=#{session[:userId]} order by constant.updated_at desc")
    end
  end 

  def fetch_cloud_tags
    unless read_fragment('tag_fragment')
      @cloud_tags = EydBlog.tag_counts
    end
  end

  def fetch_comments
    unless read_fragment('comment_fragment')
      @comments = EydComment.find_by_sql("select comment.* from eyd_comments comment where comment.is_guestbook = false order by comment.updated_at desc limit 5")
    end
  end
  
  def fetch_hottopics
    @hottopics = EydBlog.find_by_sql("select blog.* from eyd_blogs blog where blog.user_id=2 and blog.is_draft=false order by blog.view_count desc limit 5")
  end

  def fetch_archivals
    unless read_fragment('archival_fragment'+session[:userId].to_s)
      @archivals = EydBlog.find_by_sql("select year(created_at) as year, month(created_at) as month, count(id)as count from eyd_blogs where user_id=#{session[:userId]} group by year(created_at),month(created_at) order by year(created_at) desc, month(created_at) desc")
    end
  end

  def index
    @total_blogs = EydBlog.paginate_by_sql ["select blog.* from eyd_blogs blog where blog.user_id=1 and blog.is_draft=false order by blog.created_at desc"], :page => params[:page], :per_page=>20 
  end

  def tech_list
    @total_blogs = EydBlog.paginate_by_sql ["select blog.* from eyd_blogs blog where blog.user_id=2 and blog.is_draft=false order by blog.created_at desc"], :page => params[:page], :per_page=>20 
  end

  def show_blog
    @eyd_comment = EydComment.new
    @blog = EydBlog.find(params[:id])
    @total_comments = EydComment.paginate_by_sql ["select comment.* from eyd_comments comment where comment.blog_id=#{@blog.id} order by comment.updated_at asc"], :page => params[:page], :per_page=>10
    @prev_next_blogs = EydComment.find_by_sql("SELECT * FROM eyd_blogs WHERE user_id = #{session[:userId]} and id IN (SELECT CASE WHEN SIGN(id - #{@blog.id}) > 0 THEN MIN(id) WHEN SIGN(id - #{@blog.id}) < 0 THEN MAX(id) END AS id FROM eyd_blogs WHERE id <> #{@blog.id} GROUP BY SIGN(id - #{@blog.id}) ORDER BY SIGN(id - #{@blog.id})) ORDER BY id ASC")
    if @prev_next_blogs.size >1 
      @prev_blog = @prev_next_blogs[1] 
      @next_blog = @prev_next_blogs[0]
    else
      if @prev_next_blogs.size ==1  
        if @prev_next_blogs[0].id < @blog.id 
          @next_blog = @prev_next_blogs[0]
        else
          @prev_blog = @prev_next_blogs[0]
        end
      end
    end
    sync_blog_view_count(@blog)
  end

  def sync_blog_view_count(blog)
    #update blog view count
    blog.view_count+=1
    blog.update_attribute("view_count",@blog.view_count);
  end

  def tag_list
    @total_blogs = EydBlog.tagged_with(params[:id]).paginate :page => params[:page], :per_page => 50
    @tags = EydBlog.tag_counts_on(:tags)
  end

  def tag_ibook_list
    @total_ibooks = EydIbook.tagged_with(params[:id]).paginate :page => params[:page], :per_page => 50
  end

  def tag_gallery_list
    @total_avatars = EydAvatar.tagged_with(params[:id])
  end

  def archival_list
    @start = "'"+params[:id]+"-01'"
    @end = "'"+params[:id]+"-31'"
    @total_blogs = EydBlog.paginate_by_sql ["select blog.* from eyd_blogs blog where blog.user_id=#{session[:userId]} and blog.is_draft=false and blog.created_at between #{@start} and #{@end} order by blog.created_at desc"], :page => params[:page], :per_page=>50 
  end

  def category_list
    @total_blogs = EydBlog.paginate_by_sql ["select blog.* from eyd_blogs blog where blog.user_id=#{session[:userId]} and blog.is_draft=false and blog.constant_id = #{params[:id]} order by blog.updated_at desc"], :page => params[:page], :per_page=>50 
  end

  def rss_feed
    @total_blogs = EydBlog.order("created_at desc")
    @updated = @total_blogs.first.created_at unless @total_blogs.empty?
    respond_to do |format|
      format.atom {render :layout => false}
      format.rss { redirect_to rss_feed_path(:format => :atom), :status => :moved_permanently }
    end
  end

  def ibook_list 
    @total_ibooks = EydIbook.paginate_by_sql ["select ibook.* from eyd_ibooks ibook where ibook.user_id=2 order by ibook.updated_at desc"], :page => params[:page], :per_page=>20 
  end

  def download
    @ibook = EydIbook.find(params[:id])
    sync_download_count(@ibook)
    if @ibook.ibook.url!=nil
      url = @ibook.ibook.url.split("?") 
      send_file "#{RAILS_ROOT}/public"+url[0] unless @ibook.ibook.url.nil?
    end
  end

  def sync_download_count(ibook)
    ibook.download_count+=1
    ibook.update_attribute("download_count",@ibook.download_count) 
  end

  def guest_list
    @eyd_comment = EydComment.new
    @total_comments = EydComment.paginate_by_sql ["select comment.* from eyd_comments comment where comment.is_guestbook=true order by comment.updated_at desc"], :page => params[:page], :per_page=>10
  end

  def gallery_list
    @total_avatars = EydAvatar.find_by_sql("select ava.* from eyd_avatars ava where ava.user_id=1 order by ava.updated_at desc limit 280") 
  end

  private
  def fetch_index_curt  
    session[:curt_index]="current"
    session[:curt_tech] =""
    session[:curt_ibook] =""
    session[:curt_guestbk] =""
    session[:curt_gallery] =""
  end

  def fetch_ibook_curt  
    session[:curt_index]=""
    session[:curt_tech] =""
    session[:curt_ibook] ="current"
    session[:curt_guestbk] =""
    session[:curt_gallery] =""
  end

  def fetch_gallery_curt  
    session[:curt_index]=""
    session[:curt_tech] =""
    session[:curt_ibook] =""
    session[:curt_guestbk] =""
    session[:curt_gallery] ="current"
  end

  def fetch_guestbook_curt  
    session[:curt_index]=""
    session[:curt_tech] =""
    session[:curt_ibook] =""
    session[:curt_guestbk] ="current"
    session[:curt_gallery] =""
  end

  def fetch_tech_curt  
    session[:curt_index]=""
    session[:curt_tech] ="current"
    session[:curt_ibook] =""
    session[:curt_guestbk] =""
    session[:curt_gallery] =""
  end
end
