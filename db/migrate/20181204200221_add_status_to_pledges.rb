class AddStatusToPledges < ActiveRecord::Migration[5.2]
  def change
    add_column :pledges, :status, :string
  end
end
