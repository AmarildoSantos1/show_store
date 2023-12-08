class CreateItemsTAble < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :quantity
      t.string :description
      t.integer :price
    end
  end
end
