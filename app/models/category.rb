class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :categorizations
  has_many :items, through: :categorizations
end
