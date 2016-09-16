class ApplicationController < ActionController::Base
  include Sslify
  include HttpBasicate

  protect_from_forgery with: :exception

  before_filter :store_current_location, :unless => :devise_controller?

  private

  def store_current_location
    store_location_for(:user, request.url)
  end

  def after_sign_in_path_for(_resource_or_scope)
   '/portal'
  end

end
