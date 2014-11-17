CreditPlans::Application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  get '/:account_id/credit_plans', to: 'credit_plans#new', as: 'new_credit_plan'
  post '/:account_id/credit_plans', to: 'credit_plans#create', as: 'create_credit_plan'
  get '/:account_id/credit_plans/:id', to: 'credit_plans#status', as: 'check_credit_plan'
  
#   devise_for :users
  
  root 'account#index'
  
  resources :account do
    member do
      resources :credit_lines
      resources :credit_plans do
        get :status
      end
    end
  end
  
  get 'test_post', to: 'credit_plans#test_post', as: 'test_post'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
