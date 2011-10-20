class ApplicationController < ActionController::Base
  before_filter :set_i18n_locale_from_params
  before_filter :authorize
  protect_from_forgery

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  #rescue_from ActiveRecord::RecordInvalid, :with => :render_500
  #rescue_from Exception, :with => :render_500

  protected
  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.include?(params[:locale].to_sym)
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def default_url_options
    { :locale => I18n.locale }
  end


  def authorize
    unless EydUser.find_by_id(session[:user_id])
      redirect_to login_url, :notice => "Please log in"
    end
  end

  def render_404(exception = nil)
    if exception
      logger.info "Rendering 404: #{exception.message}"
    end

    @page_title = "404"
    render 'eydf_errors/404',:layout=>"login", :status => 404
  end

  def render_500(exception = nil)
    if exception
      logger.info "Rendering 500: #{exception.message}"
    end

    @page_title = "500"
    render 'eydf_errors/500',:layout=>"login", :status => 500
  end
end
