class ApplicationController < ActionController::Base
  before_filter :set_i18n_locale_from_params
  before_filter :authorize
  before_filter :filter_css_curt
  protect_from_forgery

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  #rescue_from ActiveRecord::RecordInvalid, :with => :render_500
  #rescue_from Exception, :with => :render_500

  protected
  def filter_css_curt
    case params[:action].to_s
    when 'index'
      fetch_index_curt
    when 'tech_list'
      fetch_tech_curt
    when 'ibook_list'||'tag_ibook_list'
      fetch_ibook_curt
    when 'guest_list'
      fetch_guestbook_curt
    when 'gallery_list'||'tag_gallery_list'
      fetch_gallery_curt
    end
  end

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

  private
  def fetch_index_curt
    session[:curt_index]="current"
    session[:curt_tech] =""
    session[:curt_ibook] =""
    session[:curt_guestbk] =""
    session[:curt_gallery] =""
  end

  def fetch_ibook_curt
    session[:curt_index]=""
    session[:curt_tech] =""
    session[:curt_ibook] ="current"
    session[:curt_guestbk] =""
    session[:curt_gallery] =""
  end

  def fetch_gallery_curt
    session[:curt_index]=""
    session[:curt_tech] =""
    session[:curt_ibook] =""
    session[:curt_guestbk] =""
    session[:curt_gallery] ="current"
  end

  def fetch_guestbook_curt
    session[:curt_index]=""
    session[:curt_tech] =""
    session[:curt_ibook] =""
    session[:curt_guestbk] ="current"
    session[:curt_gallery] =""
  end

  def fetch_tech_curt
    session[:curt_index]=""
    session[:curt_tech] ="current"
    session[:curt_ibook] =""
    session[:curt_guestbk] =""
    session[:curt_gallery] =""
  end
end
