class StaticPagesController < ApplicationController

  def index
    @items = Item.near(last_location, 2)
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
