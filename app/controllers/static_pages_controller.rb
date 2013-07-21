class StaticPagesController < ApplicationController

  skip_load_and_authorize_resource only:[:index, :admin, :about]

  def index
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
