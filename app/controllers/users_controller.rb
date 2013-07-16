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
      render :new
    end
  end

  def show
    @user = current_user
    @items = @user.items
    @locations = current_user.locations
    @markers = @locations.last.to_gmaps4rails unless @locations.empty?
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @image = params[:user][:image].nil? ? current_user.image : Image.create(url: params[:user][:image])
    if @user.update_attributes(first_name: params[:user][:first_name], last_name: params[:user][:last_name], image: @image)
      redirect_to user_path(current_user)
    else
      render :edit
    end
    
  end

end
