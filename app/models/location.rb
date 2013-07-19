class Location < ActiveRecord::Base
  attr_accessible :latitude, :longitude
  belongs_to :locatable, polymorphic:true

  reverse_geocoded_by :latitude, :longitude
  acts_as_gmappable

  include ActionView::Helpers::UrlHelper
  include Rails.application.routes.url_helpers

  def gmaps4rails_address
    return "#{latitude}+#{longitude}"
  end

  def gmaps4rails_infowindow
    case locatable_type
    when "Address"
      return "<h4>#{locatable.name}</h4>#{locatable.number_and_street}<br>#{locatable.city}"
    when "Item"
      return "<h4>#{link_to locatable.name, "/items/#{locatable.id}"}</h4>"
    when "User"
      return "Current Location"
    else
      return "#{locatable}"
    end
  end

  def get_link(name, path, object=nil)
    ActionController::Base.helpers.link_to name, path(object)
  end
end
