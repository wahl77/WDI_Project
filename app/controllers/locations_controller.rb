class LocationsController < ApplicationController

  def new_geotag
    location = Location.new(params[:location])
    @categories = Category.all.map{|x| x.id.to_s}
    current_user.current_location = location if current_user
    @items = Item.near(location)

    respond_to do |format| 
      format.js { render layout: false}
    end
  end
end
