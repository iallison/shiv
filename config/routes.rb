Shiv::Application.routes.draw do

  resources :cloud_environments
  resources :cloud_users

  #resources :users

  resources :cloud_accounts
  resources :cloud_environments

  

  resources :contacts


  devise_for :users

  resources  :users
  root :to => 'hosts#index'
  resources :hosts
  resources :boxes

  match "tokens" => 'tokens#create', :via => :post
  match "token/:token" => 'tokens#destroy', :via => :delete

  resources :cloud_environments
  match 'search/searchAll' => 'search#searchAll'
  resources :search
  #match 'tagged' => 'hosts#tagged', :as => 'tagged'

  match 'cli/list_hosts' => 'hosts#list_hosts'
  match 'cli/list_host_details' => 'hosts#list_host_details'
  match 'cli/list_boxes' => 'boxes#list_boxes'
  match 'cli/list_contacts' => 'contacts#list_contacts'
  match 'cli/searchAll' => 'search#searchAll'
  match 'cli/searchHost' => 'search#searchHost'
  match 'cli/searchBox' => 'search#searchBox'
  match 'cli/searchTrait' => 'search#searchTrait'
  match 'cli/searchContact' => 'search#searchContact'


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
