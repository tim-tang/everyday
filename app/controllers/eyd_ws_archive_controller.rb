class EydWsArchiveController < ApplicationController
  skip_before_filter :authorize

  def archives
    # unless read_fragment('archival_fragment1')
    @archives = EydBlog.fetch_blogs(1,params[:id],false)
    # end
    respond_to do |format|
      format.xml  { render :xml => @archives}
      format.json { render :json => @archives}
    end
  end

end
