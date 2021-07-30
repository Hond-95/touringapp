class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.integer :recruting_count
      t.integer :entry_count
      t.string :run_prefecture
      t.string :run_location
      t.string :comment
      t.datetime :event_date
      t.string :meeting_place
      t.integer :user_id

      t.timestamps
    end
  end
end
