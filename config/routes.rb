ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

    ## admin - administração da conta

  # Home
  map.resources :pages, :collection => { :mobile => :get, :musica => :get }
  # Writing
  map.resources :posts
  # Gristing
  map.resources :beer_votes
  map.resources :users
  # Observing
  map.resources :galleries, :collection => { :search => :get } do |gallery|
    gallery.resources :comments, :controller => "gallery_comments"
  end
  
  map.resources :videos do |video|
    video.resources :comments, :controller => "video_comments"
  end

  map.resources :comments

  map.resources :photos
  # Reading
  map.resources :links
  # Taking Notes
  map.resources :notes

  map.resources :attachments

  map.admin_root '/admin',  :controller => 'admin/posts', :action => 'index'
  map.namespace(:admin) do |admin|
    admin.resource :session
    admin.resources :users
    admin.resources :posts, :collection => { :preview => :post }
    admin.resources :attachments
    admin.resources :beer_votes
    admin.resources :videos
    admin.resources :galleries do |gallery|
      gallery.resources :photos, :controller => "gallery_photos"
    end
  end

  map.login  '/login',  :controller => 'admin/sessions', :action => 'new'
  map.logout '/logout', :controller => 'admin/sessions', :action => 'destroy'

  map.root :controller => "pages", :action => "index"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
