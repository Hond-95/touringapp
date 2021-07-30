class CreateUserInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :user_infos do |t|
      t.integer :age
      t.boolean :sex
      t.string :bike
      t.string :touring_area
      t.string :favorite_maker

      t.timestamps
    end
  end
end
