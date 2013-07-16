class Location < ActiveRecord::Base
  attr_accessible :latitude, :longitude
  belongs_to :locatable, polymorphic:true
end
