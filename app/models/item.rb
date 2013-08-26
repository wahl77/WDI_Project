class Item < ActiveRecord::Base

  attr_accessible :description, :name, :location_id, :category_ids, :location

  belongs_to :user

  has_many :categorizations
  has_many :categories, through: :categorizations

  has_many :images, as: :imageable, dependent: :destroy

  has_one :location, as: :locatable, dependent: :destroy


  validates :name,
    presence:true

  searchable do 
    text :name, boost: 10
    text :description, boost: 7
    integer :location_id
  end

  def self.item_search(query, location=nil, range=10)
    self.search do
      fulltext query
      with(:location_id, Location.near(location, range).map{|x| x.id})
    end
  end
end
