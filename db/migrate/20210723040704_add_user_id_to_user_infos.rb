class AddUserIdToUserInfos < ActiveRecord::Migration[6.0]
  def change
    add_column :user_infos, :user_id, :integer
  end
end
