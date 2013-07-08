ActiveAdmin.register Member do
  # index
  config.sort_order = 'name_asc'

  index do
    column :name
    column :email
    column :url
    column(:active) do |member|
      member.active ? status_tag( "yes", :ok ) : status_tag( "no" )
    end
    default_actions
  end

  filter :name
  filter :email
  filter :active, :as => :select

  # edit page
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :email
      f.input :url
      f.input :active
    end
    f.actions
  end

  # show page
  show do |member|
    attributes_table do
      row(:name)
      row(:email)
      row(:url) { link_to member.url, member.url }
      row(:active?) { member.active ? status_tag( "yes", :ok ) : status_tag( "no" ) }
      row(:image) { image_tag member.image.url(:small) }
    end
  end
end
