class EydConstantController < ApplicationController
  before_filter :authorize
  layout 'admin'
  cache_sweeper :eyd_constant_sweeper, :only=>[:create, :update, :destroy]

  def index
    @total_constants = EydConstant.paginate_by_sql ["select constant.* from eyd_constants constant where constant.user_id=#{session[:user_id]} order by constant.updated_at desc"], :page => params[:page], :per_page=>20 
  end

  def new
    @eyd_constant = EydConstant.new
  end

  def create
    @eyd_constant = EydConstant.new(params[:eyd_constant])
    @eyd_constant.user_id = session[:user_id]
    respond_to do |format|
      if @eyd_constant.save
        format.html { redirect_to(constant_index_path, :notice => 'Category was successfully created.') }
        format.xml  { render :xml => @eyd_constant, :status => :created, :location => @eyd_constant }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @eyd_constant.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @eyd_constant = EydConstant.find(params[:id]) 
  end

  def update
    @eyd_constant = EydConstant.find(params[:id])
    respond_to do |format|
      if @eyd_constant.update_attributes(params[:eyd_constant])

        format.html { redirect_to(constant_index_path, :notice => 'Constant was successfully updated.') }
        format.xml  { render :xml => @eyd_constant, :status => :updated, :location => @eyd_constant }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @eyd_constant.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    if params[:constant_ids] != nil
      params[:constant_ids].each do |constant_id|
        @eyd_constant = EydConstant.find(constant_id)
        @eyd_constant.destroy
        expire_fragment 'category_fragment'+session[:user_id].to_s
      end
    end
    respond_to do |format|
      format.html {redirect_to(constant_index_path)}
      format.xml {head ok}
    end
  end

end
