class EydfGuestbkController < ApplicationController
  skip_before_filter :authorize
  before_filter :fetch_categories, :fetch_archivals
  before_filter :build_comment, :only=> [:guest_list]

  def fetch_categories
    session[:userId]=1
    unless read_fragment('category_fragment'+session[:userId].to_s)
      @constants = EydConstant.find_by_sql("select constant.* from eyd_constants constant where constant.user_id=1 order by constant.updated_at desc")
    end
  end

  def fetch_archivals
    unless read_fragment('archival_fragment'+session[:userId].to_s)
      @archivals = EydBlog.find_by_sql("select year(created_at) as year, month(created_at) as month, count(id)as count from eyd_blogs where user_id=1 group by year(created_at),month(created_at) order by year(created_at) desc, month(created_at) desc")
    end
  end

  def guest_list
    @total_comments = EydComment.paginate_by_sql ["select comment.* from eyd_comments comment where comment.is_guestbook=true order by comment.updated_at desc"], :page => params[:page], :per_page=>10
  end

  protected
  def build_comment
    @eyd_comment = EydComment.new
  end

end
