class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.integer :target
      t.integer :guaranteed
      t.string :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
