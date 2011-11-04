Everyday::Application.routes.draw do
    root :to => "eydf_home#index"
  scope '(:locale)' do
    match 'eydf_home/rss_feed' => 'eydf_home#rss_feed', :as => :rss_feed, :defaults=> {:format => 'atom'}
    controller :eydf_home do
      get 'show_blog/:id' => :show_blog, :as => :show_blog
      get 'tag_list/:id' => :tag_list, :as => :tag_list
      get 'archival_list/:id' => :archival_list, :as => :archival_list
      get 'category_list/:id' => :category_list, :as => :category_list
      get 'search_list' => :search_list, :as => :search_list
      get 'ibook_list' => :ibook_list, :as => :ibook_list
      get 'ibook_download/:id' => :download, :as => :ibook_download
      get 'guest_book' => :guest_list, :as => :guest_book
      get 'tech_list' => :tech_list, :as => :tech_list
      get 'tag_ibook_list/:id' => :tag_ibook_list, :as => :tag_ibook_list
      get 'gallery_list' => :gallery_list, :as => :gallery_list
      get 'tag_gallery_list/:id' => :tag_gallery_list, :as => :tag_gallery_list
    end
  end

  controller :eyd_login do
    get 'login' => :login
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
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
