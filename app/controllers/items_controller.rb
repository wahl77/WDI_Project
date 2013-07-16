class ItemsController < ApplicationController
  def new
    @item = Item.new
  end
  def create
    @item = Item.new(name: params[:item][:name], description: params[:item][:description])

    @image = Image.create(url: params[:item][:image])

    @item.images << @image

    if @item.save
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

end
