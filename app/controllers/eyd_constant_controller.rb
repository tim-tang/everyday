class EydConstantController < ApplicationController
  before_filter :authorize
  before_filter :fetch_constant, :only=>[:edit,:update]
  before_filter :build_constant, :only=>[:new ]
  layout 'admin'

  def index
    @total_constants = EydConstant.fetch_admin_constants(session[:user_id], params[:page])
  end

  def new
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
  end

  def update
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
      end
    end
    respond_to do |format|
      format.html {redirect_to(constant_index_path)}
      format.xml {head ok}
    end
  end

  protected
  def fetch_constant
    @eyd_constant = EydConstant.find(params[:id])
  end

  def build_constant
    @eyd_constant = EydConstant.new
  end

end
