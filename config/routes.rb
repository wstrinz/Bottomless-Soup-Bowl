BottomlessSoupBowl::Application.routes.draw do

  get "users/index"
  get "users/show"

  devise_for :users

  resources :flavors
  resources :bsb_feeds

  match 'bsb_feeds/:id/refresh' => 'bsb_feeds#refresh', :as => :refresh_bsb_feed
  match 'bsb_feeds/:id/next' => 'bsb_feeds#next', :as => :next_feed_story
  match 'bsb_feeds/:id/prev' => 'bsb_feeds#prev', :as => :prev_feed_story
  match 'bsb_feeds/:id/start' => 'bsb_feeds#start', :as => :start_feed_story

  match 'all_bsb_feeds' => 'bsb_feeds#all', :as => :all_bsb_feeds

  match 'all_bsb_feeds/refresh' => 'bsb_feeds#refresh_all', :as => :refresh_all
  match 'all_bsb_feeds/next' => 'bsb_feeds#next_all', :as => :next_all_story
  match 'all_bsb_feeds/prev' => 'bsb_feeds#prev_all', :as => :prev_all_story
  match 'all_bsb_feeds/start' => 'bsb_feeds#start_all', :as => :start_all_story

  match 'users/showfeeds/:id' => 'users#show', :as => :user

  match 'flavors/:id/refresh' => 'flavors#calculate_scores', :as => :calculate_flavor_scores
  match 'flavors/:id/next' => 'flavors#next', :as => :next_flavor_story
  match 'flavors/:id/prev' => 'flavors#prev', :as => :prev_flavor_story
  match 'flavors/:id/start' => 'flavors#start', :as => :start_flavor_story

  match 'flavors/:id/set_algorithm' => 'flavors#set_algorithm', :as => :set_flavor_algorithm


  match 'users' => 'users#index'

  match 'users/:id/feeds' => 'users#feeds', :as => :user_feeds

  match 'import_feeds' => 'users#import_feeds', :as => :import_feeds

  match 'do_feed_import' => 'users#do_feed_import', :as => :do_feed_import

  match 'remove_all_feeds' => 'users#remove_all_feeds', :as => :remove_all_feeds


  root :to => 'users', :action => 'show_current'

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
