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
      @item.location_id = b.id
      @item.save
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
    if params[:categories].nil?
      @categories = Category.all.map{|x| x.id.to_s}
    else
      @categories = params[:categories].split(",")
    end

    @per_page = 100

    @all = Location.near(current_user.current_location, 10).where("locatable_type = ?", "Item").joins("LEFT OUTER JOIN items on items.id = locations.locatable_id").select("items.id as item_id, items.name as item_name, items.description as item_description ").joins("LEFT OUTER JOIN images on images.imageable_id = items.id and images.imageable_type = 'Item'").select("images.id as image_id, images.url as image_url").joins("LEFT OUTER JOIN categorizations on categorizations.item_id = items.id").select("array_agg(categorizations.category_id) as item_category").group("items.id, locations.id, images.id").order("item_id DESC").page(params[:page]).per_page(@per_page)
    
    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end

  def search
    @all = Item.item_search(params[:search], last_location, params[:range]).results
  end
end
