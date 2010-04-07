# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ExceptionNotification::Notifiable
  
  before_filter :set_rand_cookie
  
  protect_from_forgery
  
  protected
  def set_rand_cookie
    return if !cookies[:rand_seed].blank?
    cookies[:rand_seed] = {:value => rand(100), :expires => Time.now + 900}
  end
end
