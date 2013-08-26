class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.belongs_to :commentable, polymorphic: true
      t.references :sender

      t.timestamps
    end
    add_index :comments, [:commentable_id, :commentable_type]
    add_index :comments, :sender_id
  end
end
