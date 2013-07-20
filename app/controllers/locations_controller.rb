class LocationsController < ApplicationController

  skip_before_filter :require_login, only:[:new_geotag]

  def new_geotag
    location = Location.new(params[:location])
    current_user.current_location = location if current_user
    @items = []
    @locations = Location.where("locatable_type = ?", "Item").sample(5)
    @locations.each do |location|
      @items << Item.find(location.locatable_id)
      
    end
    respond_to do |format| 
      format.js { render layout: false}
    end
  end
end
