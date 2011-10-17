class EydfHomeController < ApplicationController
  skip_before_filter :authorize

  def index
    @total_blogs = EydBlog.paginate_by_sql ["select blog.* from eyd_blogs blog where blog.user_id=1 and blog.is_draft=false order by blog.updated_at desc"], :page => params[:page], :per_page=>5 
  end

  def show_blog
    @eyd_comment = EydComment.new
    @blog = EydBlog.find(params[:id])
    @total_comments = EydComment.paginate_by_sql ["select comment.* from eyd_comments comment where comment.blog_id=#{params[:id]} order by comment.updated_at asc"], :page => params[:page], :per_page=>10
    @prev_next_blogs = EydComment.find_by_sql("SELECT * FROM eyd_blogs WHERE id IN (SELECT CASE WHEN SIGN(id - #{params[:id]}) > 0 THEN MIN(id) WHEN SIGN(id - #{params[:id]}) < 0 THEN MAX(id) END AS id FROM eyd_blogs WHERE id <> #{params[:id]} GROUP BY SIGN(id - #{params[:id]}) ORDER BY SIGN(id - #{params[:id]})) ORDER BY id ASC")
    if @prev_next_blogs.size >1 
     @prev_blog = @prev_next_blogs[1] 
     @next_blog = @prev_next_blogs[0]
    else
      if @prev_next_blogs[0].id < params[:id].to_i 
        @next_blog = @prev_next_blogs[0]
      else
        @prev_blog = @prev_next_blogs[0]
      end
    end
  end


  def tag_list
    @total_blogs = EydBlog.tagged_with(params[:id]).paginate :page => params[:page], :per_page => 20
    @tags = EydBlog.tag_counts_on(:tags)
  end

  def archival_list
    @start = "'"+params[:id]+"-01'"
    @end = "'"+params[:id]+"-31'"
    @total_blogs = EydBlog.paginate_by_sql ["select blog.* from eyd_blogs blog where blog.user_id=1 and blog.is_draft=false and blog.updated_at between #{@start} and #{@end} order by blog.updated_at desc"], :page => params[:page], :per_page=>5 
  end

  def category_list
    @total_blogs = EydBlog.paginate_by_sql ["select blog.* from eyd_blogs blog where blog.user_id=1 and blog.is_draft=false and blog.constant_id = #{params[:id]} order by blog.updated_at desc"], :page => params[:page], :per_page=>5 
  end

  def rss_feed
    @total_blogs = EydBlog.order("updated_at desc")
    @updated = @total_blogs.first.updated_at unless @total_blogs.empty?
    respond_to do |format|
      format.atom {render :layout => false}
      format.rss { redirect_to rss_feed_path(:format => :atom), :status => :moved_permanently }
    end
  end

end
