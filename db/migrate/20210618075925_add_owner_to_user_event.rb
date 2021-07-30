class AddOwnerToUserEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :user_events, :owner, :boolean
  end
end
