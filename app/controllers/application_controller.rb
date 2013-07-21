class ApplicationController < ActionController::Base
  protect_from_forgery
  #before_filter :require_login
  load_and_authorize_resource 

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to user_path(current_user), alert: "Message: #{exception.message}"
  end
end
