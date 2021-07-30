class RemoveOrganizerFlgFromEvents < ActiveRecord::Migration[6.0]
  def change
    remove_column :events, :organizer_flg, :boolean
  end
end
