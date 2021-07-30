class AddOwnerIdToUserEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :user_events, :owner_id, :integer
  end
end
