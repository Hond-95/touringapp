class RemoveOwnerFromUserEvents < ActiveRecord::Migration[6.0]
  def change
    remove_column :user_events, :owner, :boolean
  end
end
