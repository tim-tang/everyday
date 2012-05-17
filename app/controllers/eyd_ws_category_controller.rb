class EydWsCategoryController < ApplicationController
  skip_before_filter :authorize

  def categories
    @constants = EydConstant.where(:user_id =>1).order('updated_at desc')
    respond_to do |format|
      format.xml  { render :xml => @constants}
      format.json { render :json => @constants}
    end
  end

  def category
    @constant = EydConstant.find(params[:id])
    respond_to do |format|
      format.xml  { render :xml => @constant}
      format.json { render :json => @constant}
    end
  end
end
