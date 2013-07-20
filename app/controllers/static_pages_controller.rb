class StaticPagesController < ApplicationController

  skip_before_filter :require_login, only:[:index, :admin]

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
