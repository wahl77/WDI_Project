class ItemsController < ApplicationController

  #need the following line, otherwise, it breaks for some reason
  skip_load_and_authorize_resource only:[:create]#except:[:around_me]

  def new
    @item = Item.new
    @item_locations = current_user.current_location.nil? ? [] : [["Current Location", current_user.current_location.id]] 
    @item_locations += current_user.addresses.map{|x| [x.name, x.location.id]}
  end

  def create
    loc = Location.find(params[:item][:location])
    b = loc.dup 
    @item = Item.new(name: params[:item][:name], description: params[:item][:description], category_ids: params[:item][:category_ids])
    @image = Image.create(url: params[:item][:image]) unless params[:item][:image].nil?
    @item.images << @image unless @image.nil?
    if @item.save
      b.save
      @item.location = b
      current_user.items << @item
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def update
    @item = Item.find(params[:id])
    @item.update_attributes(name: params[:item][:name], description: params[:item][:description], category_ids: params[:item][:category_ids])
    @item.images << Image.create(url: params[:item][:image]) unless params[:item][:image].nil? 

    redirect_to item_path(@item)
  end

  def edit
    @item = Item.find(params[:id])
    @item_locations = current_user.current_location.nil? ? [] : [["Current Location", current_user.current_location.id]] 
    @item_locations += current_user.addresses.map{|x| [x.name, x.location.id]}
  end
  def show
    @item = Item.find(params[:id])
    #@item =  Item.joins(:images).where("items.id = ? OR images.imageable_id = ? AND images.imageable_type = 'Item'", params[:id], params[:id]).select("items.*, images.url as image_url").first
  end

  def index
    @items = current_user.items
    @item = Item.new
  end

  def destroy
    item = Item.find(params[:id])
    if current_user.items.include? item
      item.destroy
      redirect_to items_path
    else
      redirect_to root_path, alert: "You do not have the right"
    end 
  end

  def around_me
    @per_page = 5
    query = []
    @locations = Location.page(params[:page]).per_page(@per_page).near(current_user.current_location, 10).where("locatable_type = ?", "Item").joins("LEFT OUTER JOIN items on items.id = locations.locatable_id").select("items.id as item_id") 
    @locations.each do |location|
      query << location.item_id
    end
    @items = Item.find(query)

    respond_to do |format|
      format.html
      format.js { render layout: false }
    end

    #@per_page = 5
    #@items = Item.around(current_user.current_location)
    ##.page(params[:page]).per_page(@per_page)
    #@locations = []
    #@items.each do |item|
    #  @locations << item.location
    #end
  end
end
