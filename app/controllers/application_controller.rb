class ApplicationController < ActionController::Base
  before_filter :set_i18n_locale_from_params
  before_filter :filter_css_curt
  before_filter :filter_right_fragments, :except=>[:gallery_list, :tag_gallery_list]
  before_filter :authorize
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

  def filter_right_fragments
    fetch_cloud_tags
    fetch_comments
    fetch_hottopics
  end

  def fetch_cloud_tags
    unless read_fragment('tag_fragment')
      @cloud_tags = EydBlog.tag_counts
    end
  end

  def fetch_comments
    unless read_fragment('comment_fragment')
      @comments = EydComment.find_by_sql("select comment.* from eyd_comments comment where comment.is_guestbook = false order by comment.updated_at desc limit 5")
    end
  end

  def fetch_hottopics
    @hottopics = EydBlog.find_by_sql("select blog.* from eyd_blogs blog where blog.user_id=2 and blog.is_draft=false order by blog.view_count desc limit 5")
  end

end
