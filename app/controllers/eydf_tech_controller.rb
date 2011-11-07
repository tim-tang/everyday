class EydfTechController < ApplicationController
  skip_before_filter :authorize
  before_filter :fetch_categories, :fetch_archivals

  def fetch_categories
    session[:userId]=2
    unless read_fragment('category_fragment'+session[:userId].to_s)
      @constants = EydConstant.find_by_sql("select constant.* from eyd_constants constant where constant.user_id=2 order by constant.updated_at desc")
    end
  end

  def fetch_archivals
    unless read_fragment('archival_fragment_tech'+session[:userId].to_s)
      @archivals = EydBlog.find_by_sql("select year(created_at) as year, month(created_at) as month, count(id)as count from eyd_blogs where user_id=2 group by year(created_at),month(created_at) order by year(created_at) desc, month(created_at) desc")
    end
  end

  def tech_list
    @total_blogs = EydBlog.paginate_by_sql ["select blog.* from eyd_blogs blog where blog.user_id=2 and blog.is_draft=false order by blog.created_at desc"], :page => params[:page], :per_page=>20
  end

end
