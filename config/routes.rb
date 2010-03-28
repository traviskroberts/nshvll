ActionController::Routing::Routes.draw do |map|
  Typus::Routes.draw(map)
  map.root :controller => 'members', :action => 'index'
  
  map.resources :members, :only => [:index, :new, :create], :member => {:email => 'get'}
  map.member_confirm 'member/confirm', :controller => 'members', :action => 'confirm'
  map.member_activate 'member/activate/:activation_code', :controller => 'members', :action => 'activate'

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
