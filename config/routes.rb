Everyday::Application.routes.draw do
  scope '(:locale)' do
    controller :eyd_ws_blog do
      get 'blogs/:id' => :blogs, :as=> :blogs
      get 'blogs/:id/search' => :search, :as=>:search
      get 'blogs/:id/:dt' => :category, :as=>:category
      get 'hot/topics' => :hot, :as =>:hot
      get 'blog/:id' => :blog, :as=>:blog
      get 'blog/:id/next' => :next_blog, :as=>:blog
      put 'blog/:id/sync' => :sync_count, :as => :blog
    end

    controller :eyd_ws_category do
      get 'categories' =>:categories, :as => :categories
      get 'category/:id'=>:category, :as => :category
    end

    controller :eyd_ws_archive do
      get 'archives/:id' =>:archives, :as => :archives
    end

    controller :eyd_ws_avatar do
      get 'avatars/:id' =>:avatars, :as => :avatars
    end
  end

  controller :eyd_login do
    get 'login'=>:login
    post 'login' => :authentication
    delete 'logout' => :destroy
  end

  controller :eyd_admin do
    get 'admin' => :index
  end

  controller :eyd_blog do
    get 'blog_index' => :index
    get 'blog_draft' => :draft
    get 'blog_edit/:id' => :edit, :as => :blog_edit
    get 'blog_new' => :new
    put 'blog_update/:id' => :update, :as => :blog_update
    post 'blog_create' => :create
    post 'blog_destroy' => :destroy
  end

  controller :eyd_constant do
    get 'constant_index' => :index
    get 'constant_draft' => :draft
    get 'constant_edit/:id' => :edit, :as => :constant_edit
    get 'constant_new' => :new
    put 'constant_update/:id' => :update, :as => :constant_update
    post 'constant_create' => :create
    post 'constant_destroy' => :destroy
  end

  controller :eyd_avatar do
    get 'avatar_index' => :index
    get 'avatar_show/:id' => :show, :as => :avatar_show
    get 'avatar_new' => :new
    post 'avatar_upload' => :upload
    post 'avatar_destroy' => :destroy
  end

  controller :eyd_ibook do
    get 'ibook_index' => :index
    get 'ibook_show/:id' => :show, :as => :ibook_show
    get 'ibook_new' => :new
    post 'ibook_upload' => :upload
    post 'ibook_destroy' => :destroy
  end

  controller :eyd_comment do
    get 'comment_index' => :index
    post 'comment_destroy' => :destroy
    post 'comment_create' => :create
  end
end
