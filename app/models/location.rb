class Location < ActiveRecord::Base
  attr_accessible :latitude, :longitude
  belongs_to :locatable, polymorphic:true

  acts_as_gmappable

  def gmaps4rails_address
    return "#{latitude}+#{longitude}"
  end
end
