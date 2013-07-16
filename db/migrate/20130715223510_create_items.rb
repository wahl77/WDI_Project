class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.references :user

      t.timestamps
    end
    add_index :items, :user_id
  end
end
