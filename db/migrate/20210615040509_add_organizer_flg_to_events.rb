class AddOrganizerFlgToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :organizer_flg, :boolean
  end
end
