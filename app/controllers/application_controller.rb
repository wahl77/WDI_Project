class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login
end
