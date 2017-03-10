class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :quantity
      t.decimal :price, precision: 8, scale: 2
      t.string :barcode

      t.timestamps
    end
  end
end
