class Item < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :name, :location_id

  has_many :images, as: :imageable, dependent: :destroy

  has_one :location, as: :locatable, dependent: :destroy


  # Get a list of items which are around a current location
  def self.around(location, range=100)
    
    #items = []
    #Location.near(location, 100).where("locatable_type = ?", "Item").each do |location|
    #  items << Item.find(location.locatable_id)
    #end
    #return items
  end

end
