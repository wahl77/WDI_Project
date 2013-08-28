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
      @item.location = b
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

    @items = Item.near(last_location, 2).sample(25)

    @items = @items.map{|item| item if (item.categorizations.pluck(:category_id).map{|x| x.to_s} - @categories).size < item.categorizations.pluck(:category_id).map{|x| x.to_s}.size }.compact

    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end

  def search
    @query = params[:search]
    @items = Item.item_search(@query, last_location, params[:range])
  end
end
