class ApplicationController < ActionController::Base
  include Sslify
  include HttpBasicate

  protect_from_forgery with: :exception

  before_action :store_current_location, :unless => :devise_controller?

  private

  def store_current_location
    store_location_for(:user, request.url)
  end

  def after_sign_in_path_for(_resource)    
    session[:user_return_to] || '/portal'
  end

end
