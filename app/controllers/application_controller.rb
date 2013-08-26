class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to user_path(current_user), alert: "Message: #{exception.message}"
  end
end
