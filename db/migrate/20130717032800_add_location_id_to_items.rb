class AddLocationIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :location_id, :integer
  end
end
