class EydCommentSweeper < ActionController::Caching::Sweeper
  observe EydComment

  def after_save(comment)
    expire_cache(comment)
  end

  def after_destory(comment)
    expire_cache(comment)
  end

  def expire_cache(comment)
   # expire_fragment ({:category_fragment=>session[:user_id]})
    expire_fragment 'comment_fragment'
  end
end
