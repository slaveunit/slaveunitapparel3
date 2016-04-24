class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :colour
      t.decimal :price, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
