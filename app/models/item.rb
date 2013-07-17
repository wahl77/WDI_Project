class Item < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :name, :location_id

  has_many :images, as: :imageable, dependent: :destroy
  belongs_to :location

  has_one :address, through: :location

end
