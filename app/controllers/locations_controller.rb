class LocationsController < ApplicationController

  def new_geotag
    location = Location.create(params[:location])
    current_user.locations << location if current_user 
  end
end
