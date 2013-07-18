class ItemsController < ApplicationController
  def new
    @item = Item.new
    @item_locations = current_user.current_location.nil? ? [] : [["Current Location", current_user.current_location.id]] 
    @item_locations += current_user.addresses.map{|x| [x.name, x.location.id]}
  end
  def create
    loc = Location.find(params[:item][:location])
    b = loc.dup # Copy locaiton as a new field
    @item = Item.new(name: params[:item][:name], description: params[:item][:description])
    @image = Image.create(url: params[:item][:image]) unless params[:item][:image].nil?
    @item.images << @image unless @image.nil?
    if @item.save
      @item.location = b
      current_user.items << @item
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def update
    @item = Item.find(params[:id])
    @item.update_attributes(name: params[:item][:name], description: params[:item][:description])
    @item.images << Image.create(url: params[:item][:image]) unless params[:item][:image].nil? 

    redirect_to item_path(@item)
  end

  def edit
    @item = Item.find(params[:id])
  end
  def show
    @item = Item.find(params[:id])
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
    @items = Item.around(current_user.current_location)
  end
end
