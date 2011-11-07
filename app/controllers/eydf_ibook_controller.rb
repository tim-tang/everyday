class EydfIbookController < ApplicationController
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

  def ibook_list
    @total_ibooks = EydIbook.paginate_by_sql ["select ibook.* from eyd_ibooks ibook where ibook.user_id=2 order by ibook.updated_at desc"], :page => params[:page], :per_page=>20
  end

  def tag_ibook_list
    @total_ibooks = EydIbook.tagged_with(params[:id]).paginate :page => params[:page], :per_page => 50
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
    ibook.update_attribute("download_count",ibook.download_count)
  end

end
