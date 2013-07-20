class UsersController < ApplicationController

  skip_before_filter :require_login, only:[:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path, notice:"User Created, go ahead and log in"
    else
      @user.build_image
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @items = @user.items
    @locations = []
    @user.addresses.each{|address|
      @locations << address.location
    }
  end

  def edit
    @user = current_user
    @user.build_image if @user.image.nil?
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to user_path(current_user)
    else
      @user.build_image
      render :edit
    end
    
  end

end
