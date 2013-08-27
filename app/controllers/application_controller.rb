class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to user_path(current_user), alert: "Message: #{exception.message}"
  end

  def last_location
    location = Location.new
    if current_user && current_user.last_location_is_good? 
      location = current_user.current_location
    else
      @ip = Geocoder.search("#{request.ip}")
      location = Location.new(latitude: @ip.first.latitude, longitude: @ip.first.longitude)
      location = Location.new(latitude: @ip.first.latitude, longitude: @ip.first.longitude)
    end
  end
end
