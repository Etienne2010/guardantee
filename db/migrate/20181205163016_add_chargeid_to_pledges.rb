class AddChargeidToPledges < ActiveRecord::Migration[5.2]
  def change
    add_column :pledges, :chargeid, :string
  end
end
