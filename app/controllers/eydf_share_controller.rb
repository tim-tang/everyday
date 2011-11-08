class EydfShareController < ApplicationController
  skip_before_filter :authorize
  before_filter :fetch_categories, :fetch_archivals
  before_filter :build_comment, :only=> [:show_blog]

  def fetch_categories
    unless read_fragment('category_fragment'+session[:userId].to_s)
      @constants = EydConstant.where(:user_id =>session[:userId]).order('updated_at desc')
    end
  end

  def fetch_archivals
    unless read_fragment('archival_fragment'+session[:userId].to_s)
      @archivals = EydBlog.fetch_archival_list(session[:userId])
    end
  end

  def show_blog
    #debugger
    @blog = EydBlog.find(params[:id])
    @total_comments = EydComment.fetch_blog_comments(@blog.id, params[:page])
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
    blog.update_attribute("view_count",blog.view_count);
  end




  def tag_list
    @total_blogs = EydBlog.tagged_with(params[:id]).paginate :page => params[:page], :per_page => 50
    @tags = EydBlog.tag_counts_on(:tags)
  end

  def archival_list
    @start = "'"+params[:id]+"-01'"
    @end = "'"+params[:id]+"-31'"
    @total_blogs = EydBlog.fetch_archival_blogs(session[:userId],@start,@end,params[:page],false)
  end

  def category_list
    @total_blogs = EydBlog.fetch_category_blogs(session[:userId],params[:page],params[:id],false)
  end

  def search_list
    @search = EydBlog.search do
      fulltext params[:search]
    end
    @total_blogs = @search.results
  end

  def rss_feed
    @total_blogs = EydBlog.order("created_at desc")
    @updated = @total_blogs.first.created_at unless @total_blogs.empty?
    respond_to do |format|
      format.atom {render :layout => false}
      format.rss { redirect_to rss_feed_path(:format => :atom), :status => :moved_permanently }
    end
  end

  protected
  def build_comment
    @eyd_comment = EydComment.new
  end
end
