class EydfGuestbkController < ApplicationController
  skip_before_filter :authorize
  before_filter :fetch_categories, :fetch_archivals
  before_filter :build_comment, :only=> [:guest_list]

  def fetch_categories
    session[:userId]=1
    unless read_fragment('category_fragment'+session[:userId].to_s)
      @constants = EydConstant.where(:user_id =>1).order('updated_at desc')
    end
  end

  def fetch_archivals
    unless read_fragment('archival_fragment'+session[:userId].to_s)
      @archivals = EydBlog.find_by_sql("select year(created_at) as year, month(created_at) as month, count(id)as count from eyd_blogs where user_id=1 group by year(created_at),month(created_at) order by year(created_at) desc, month(created_at) desc")
    end
  end

  def guest_list
    @total_comments = EydComment.fetch_guestbk_comments(params[:page],true)
  end

  protected
  def build_comment
    @eyd_comment = EydComment.new
  end

end
