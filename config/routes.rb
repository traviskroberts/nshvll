Nshvll::Application.routes.draw do
  root :to => 'members#index'

  resources :members do
    get :email, :on => :member
  end

  match 'member/confirm' => 'members#confirm', :as => 'member_confirm'
  match 'member/activate/:activation_code' => 'members#activate', :as => 'member_activate'
  match 'category/:slug' => 'members#by_category', :as => 'category'
  match 'member/edit' => 'members#generate_edit', :as => 'member_generate_edit'
  match 'member/edit/:edit_code' => 'members#edit', :as => 'member_edit'
end
