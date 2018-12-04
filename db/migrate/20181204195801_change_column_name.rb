class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :pledges, :type, :typeaction
  end
end
