class StaticPagesController < ApplicationController

  def index
    @ip = Geocoder.search("#{request.ip}")
    location = Location.new(latitude: @ip.first.latitude, longitude: @ip.first.longitude)
    location = Location.new(latitude: @ip.first.latitude, longitude: @ip.first.longitude)
    @items = Location.near(location, 150).where("locatable_type = ?", "Item").joins("LEFT OUTER JOIN items on items.id = locations.locatable_id").select("items.id as item_id, items.name as item_name, items.description as item_description ").joins("LEFT OUTER JOIN images on images.imageable_id = items.id and images.imageable_type = 'Item'").select("images.id as image_id, images.url as image_url").joins("LEFT OUTER JOIN categorizations on categorizations.item_id = items.id").select("array_agg(categorizations.category_id) as item_category").group("items.id, locations.id, images.id").order("item_id DESC").sample(5)
  end

  def admin
    @items = Item.all
    @locations = []
    @items.each do |item|
      @locations << item.location
    end
  end

  def about
  end
end
