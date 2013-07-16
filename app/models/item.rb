class Item < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :name

  has_many :image, as: :imageable, dependent: :destroy
end
