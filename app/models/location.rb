class Location < ActiveRecord::Base
  attr_accessible :latitude, :longitude
  belongs_to :locatable, polymorphic:true

  acts_as_gmappable :process_geocoding => false,
    :check_process => false

  def gmaps4rails_address
    return "#{self.latitude}, #{self.longitude}"
  end
end
