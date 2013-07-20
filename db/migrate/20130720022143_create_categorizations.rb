class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.references :item
      t.references :category

      t.timestamps
    end
    add_index :categorizations, :item_id
    add_index :categorizations, :category_id
  end
end
