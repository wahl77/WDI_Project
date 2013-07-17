class AddressesController < ApplicationController
  def new
  end

  def create
    current_user.addresses.create(params[:address])
    redirect_to user_path(current_user)
  end

  def destroy
    address = Address.find(params[:id])
    if current_user.addresses.include? address
      address.destroy
    end
      
    redirect_to user_path(current_user)
  end
end
