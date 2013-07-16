class Item < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :name

  has_many :images, as: :imageable
end
