class LocationsController < ApplicationController

  def new_geotag
    location = Location.new(params[:location])
    binding.pry
    current_user.current_location = location if current_user
    head 200
  end
end
