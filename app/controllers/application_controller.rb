class ApplicationController < ActionController::Base
  include Sslify

  #http_basic_authenticate_with :name => ENV['HTTP_BASIC_USERNAME'], :password => ENV['HTTP_BASIC_PASSWORD'] if (Rails.env.cloudfoundry? || Rails.env.staging?)

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: []

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

end
