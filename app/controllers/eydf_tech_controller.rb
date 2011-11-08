class EydfTechController < ApplicationController
  skip_before_filter :authorize
  before_filter :fetch_categories, :fetch_archivals

  def fetch_categories
    session[:userId]=2
    unless read_fragment('category_fragment'+session[:userId].to_s)
      @constants = EydConstant.where(:user_id =>2).order('updated_at desc')
    end
  end

  def fetch_archivals
    unless read_fragment('archival_fragment_tech'+session[:userId].to_s)
      @archivals = EydBlog.fetch_archival_list(2)
    end
  end

  def tech_list
    @total_blogs = EydBlog.fetch_blogs(2,params[:page],false)
  end

end
