class Item < ActiveRecord::Base
  
  searchable do 
    text :name, boost: 10
    text :description, boost: 7
  end

  attr_accessible :description, :name, :location_id, :category_ids, :location

  belongs_to :user

  has_many :categorizations
  has_many :categories, through: :categorizations

  has_many :images, as: :imageable, dependent: :destroy

  has_one :location, as: :locatable, dependent: :destroy


  validates :name,
    presence:true

  # Get a list of items which are around a current location
  def self.around(location, range=100)
    
    #items = []
    #Location.near(location, 100).where("locatable_type = ?", "Item").each do |location|
    #  items << Item.find(location.locatable_id)
    #end
    #return items
  end

  def self.item_search(query)
    self.search do
      fulltext query
    end
  end

end
