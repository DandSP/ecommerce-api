class CreateWeapons < ActiveRecord::Migration[6.0]
  def change
    create_table :weapons do |t|
      t.string :name
      t.string :description
      t.string :power_base
      t.string :power_step
      t.string :level

      t.timestamps
    end
  end
end
