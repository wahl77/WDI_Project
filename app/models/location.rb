class Location < ActiveRecord::Base
  attr_accessible :latitude, :longitude
  belongs_to :locatable, polymorphic:true

  reverse_geocoded_by :latitude, :longitude
  acts_as_gmappable

  def gmaps4rails_address
    return "#{latitude}+#{longitude}"
  end

  def gmaps4rails_infowindow
    case locatable_type
    when "Address"
      return "<h4>#{locatable.name}</h4>#{locatable.number_and_street}<br>#{locatable.city}"
    when "Item"
      return "<h4>#{locatable.name}</h4>#{locatable.description}"
    when "User"
      return "Current Location"
    else
      return "#{locatable}"
    end
  end
end
