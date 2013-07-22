class LocationsController < ApplicationController

  skip_load_and_authorize_resource only:[:new_geotag]

  def new_geotag
    location = Location.new(params[:location])
    @categories = Category.all.map{|x| x.id.to_s}
    current_user.current_location = location if current_user
    @all = Location.near(location, 10).where("locatable_type = ?", "Item").joins("LEFT OUTER JOIN items on items.id = locations.locatable_id").select("items.id as item_id, items.name as item_name, items.description as item_description ").joins("LEFT OUTER JOIN images on images.imageable_id = items.id and images.imageable_type = 'Item'").select("images.id as image_id, images.url as image_url").joins("LEFT OUTER JOIN categorizations on categorizations.item_id = items.id").select("categorizations.category_id as item_category").order("item_id DESC").sample(5)

    respond_to do |format| 
      format.js { render layout: false}
    end
  end
end
