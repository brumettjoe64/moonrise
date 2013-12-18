Moonrise::Application.routes.draw do

  resources :emails do
    collection do 
      get 'admin' => :admin, as: 'admin'
    end
    member do
      put 'ship' => :ship, as: 'ship'
    end
  end

#  controller :admin_mailer do
#    get 'mail' => :index, as: 'mail'
#    put 'mail/send' => :send_mail, as: 'send_mail'
#  end
  
  resources :photos do
    collection do
      get 'admin'  => :admin, as: 'admin'
    end
  end

  resources :blogs do
    collection do
      get 'admin'  => :admin, as: 'admin'
    end
  end

  resources :details do
    collection do
      get 'admin' => :admin, as: 'admin'
    end
  end

  resources :groups do
    member do 
      put 'add_guest' => :add_guest
    end
    collection do 
      get 'admin' => :admin, as: 'admin' 
    end
  end

  resources :guests do
    collection do
      get 'admin'  => :admin, as: 'admin'
      get 'modify' => :edit_info, as: 'modify_party'
      put 'modify' => :update_info
      get 'rsvp'   => :edit_rsvp, as: 'rsvp'
      put 'rsvp'   => :update_rsvp
    end
  end
#  controller :guests do
#    get 'guests/modify' => :edit_info, as: 'modify_party'
#    put 'guests/modify' => :update_info
#  end

  #controller :guests do
  #  get 'edit_guests' => :edit_guests
  #end

  resources :likes
  resources :comments do
    collection do
      get 'expand' => :expand, as: 'expand'
      get 'collapse' => :collapse, as: 'collapse'
    end
  end


  controller :sessions do
    get 'login_admin' => :new_admin
    post 'login_admin' => :create_admin
    get 'login' => :new
    post 'login' => :create 
    delete 'logout' => :destroy, as: 'logout'
  end

  root :to => "home#index", as: "home"

  match 'rhodeisland' => "ri#index", as: "ri"
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
