class EydConstantSweeper < ActionController::Caching::Sweeper
  observe EydConstant

  def after_save(product)
    expire_cache(product)
  end

  def after_destory(product)
    expire_cache(product)
  end

  def expire_cache(product)
   # expire_fragment ({:category_fragment=>session[:user_id]})
    expire_fragment 'category_fragment'+session[:user_id].to_s
  end
end
