ActionController::Routing::Routes.draw do |map|
  map.resources :languages

  map.resources :users, :only => [:edit, :update]
  
  map.resources :components, :member => {
      :install => :put, :uninstall => :put, :simulate => :put
  }

  map.resources :simulations, :member => {
      :cancel => :put, :update_status => :get, :retrieve_result => :put
  }

  map.resources :data_files

  map.resources :algorithms, :member => {
      :install => :put, :uninstall => :put
  }

  map.resources :computers, :member => {
      :test => :get, :init => :get, :queue => :get
  }

  map.signin  '/signin',  :controller => 'clearance/sessions', :action => 'new'
  map.signout '/signout', :controller => 'clearance/sessions', :action => 'destroy'
  map.signout '/signup', :controller => 'clearance/users', :action => 'new'


  map.root :controller => 'common'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
