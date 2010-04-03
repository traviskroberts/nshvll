class AddEditFieldsToMembers < ActiveRecord::Migration
  def self.up
    add_column :members, :edit_code, :string
    add_column :members, :edit_time, :datetime
  end

  def self.down
    remove_column :members, :edit_time
    remove_column :members, :edit_code
  end
end
