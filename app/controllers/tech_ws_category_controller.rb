class TechWsCategoryController < ApplicationController
  skip_before_filter :authorize

  def categories
    @constants = EydConstant.where(:user_id =>2).order('updated_at desc')
    respond_to do |format|
      format.xml  { render :xml => @constants}
      format.json { render :json => @constants}
    end
  end


end
