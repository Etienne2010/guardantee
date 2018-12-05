class CreatePledges < ActiveRecord::Migration[5.2]
  def change
    create_table :pledges do |t|
      t.integer :amount_cents
      t.string :type
      t.integer :project
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
