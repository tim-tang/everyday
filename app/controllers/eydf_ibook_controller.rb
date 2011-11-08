class EydfIbookController < ApplicationController
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

  def ibook_list
    @total_ibooks = EydIbook.fetch_ibooks(2,params[:page])
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
