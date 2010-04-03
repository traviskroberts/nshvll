ActionController::Routing::Routes.draw do |map|
  Typus::Routes.draw(map)
  map.root :controller => 'members', :action => 'index'
  
  map.resources :members, :member => {:email => 'get'}
  
  map.with_options :controller => 'members' do |m|
    m.member_confirm 'member/confirm', :action => 'confirm'
    m.member_activate 'member/activate/:activation_code', :action => 'activate'
    m.category 'category/:slug', :action => 'by_category'
    m.member_generate_edit 'member/edit', :action => 'generate_edit'
    m.member_edit 'member/edit/:edit_code', :action => 'edit'
  end

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
