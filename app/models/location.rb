class Location < ActiveRecord::Base
  attr_accessible :latitude, :longitude
  belongs_to :locatable, polymorphic:true

  acts_as_gmappable

  def gmaps4rails_address
    return "#{latitude}+#{longitude}"
  end

  def gmaps4rails_infowindow
    if locatable.class == Address
      return locatable.name
    end
  end
end
