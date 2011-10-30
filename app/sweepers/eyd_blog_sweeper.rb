class EydBlogSweeper < ActionController::Caching::Sweeper
  observe EydBlog

  def after_save(blog)
    expire_cache(blog)
  end

  def after_destory(blog)
    expire_cache(blog)
  end

  def expire_cache(blog)
    expire_fragment 'tag_fragment'
    expire_fragment 'archival_fragment'+session[:user_id].to_s
  end
end
