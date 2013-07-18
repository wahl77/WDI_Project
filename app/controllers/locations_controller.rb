class LocationsController < ApplicationController

  skip_before_filter :require_login, only:[:new_geotag]

  def new_geotag
    location = Location.new(params[:location])
    current_user.current_location = location if current_user
    @items = Item.around(location)
    render layout: false
  end
end
