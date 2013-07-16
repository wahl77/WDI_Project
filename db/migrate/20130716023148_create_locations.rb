class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.float :latitude
      t.float :longitude
      t.belongs_to :locatable, polymorphic: true

      t.timestamps
    end
    add_index :locations, [:locatable_id, :locatable_type]
  end
end
