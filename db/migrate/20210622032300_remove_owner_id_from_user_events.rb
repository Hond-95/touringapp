class RemoveOwnerIdFromUserEvents < ActiveRecord::Migration[6.0]
  def change
    remove_column :user_events, :owner_id, :integer
  end
end
