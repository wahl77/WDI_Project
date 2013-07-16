class LocationsController < ApplicationController

  def new_geotag
    location = Location.create(params[:location])

    binding.pry
    current_user.locations << location if current_user 
  end
end
