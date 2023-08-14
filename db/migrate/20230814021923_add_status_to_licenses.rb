class AddStatusToLicenses < ActiveRecord::Migration[6.0]
  def change
    add_column :licenses, :status, :integer
  end
end
