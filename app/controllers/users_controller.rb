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

end
