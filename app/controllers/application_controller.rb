class ApplicationController < ActionController::Base
  include Sslify

  protect_from_forgery with: :exception

end
