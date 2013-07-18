class Item < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :name, :location_id

  has_many :images, as: :imageable, dependent: :destroy

  has_one :location, as: :locatable

end
