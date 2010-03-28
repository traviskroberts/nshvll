class CreateCategoriesMembersTable < ActiveRecord::Migration
  def self.up
    create_table :categories_members, :id => false do |t|
      t.integer :category_id
      t.integer :member_id
    end
  end

  def self.down
    drop_table :categories_members
  end
end
