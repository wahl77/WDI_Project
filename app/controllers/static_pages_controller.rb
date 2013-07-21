class StaticPagesController < ApplicationController

  skip_load_and_authorize_resource only:[:index, :admin]

  def index
  end

  def admin
    @items = Item.all
    @locations = []
    @items.each do |item|
      @locations << item.location
    end

  end
end
