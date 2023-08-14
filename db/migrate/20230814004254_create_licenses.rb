class CreateLicenses < ActiveRecord::Migration[6.0]
  def change
    create_table :licenses do |t|
      t.string :key
      t.string :game_id

      t.timestamps
    end
  end
end
