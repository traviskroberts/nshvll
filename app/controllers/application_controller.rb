class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_rand_cookie

  protected
  def set_rand_cookie
    return if !cookies[:rand_seed].blank?
    cookies[:rand_seed] = {:value => rand, :expires => Time.now + 900}
  end
end
