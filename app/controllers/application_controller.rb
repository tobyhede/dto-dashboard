class ApplicationController < ActionController::Base
  include Sslify
  include HttpBasicate

  protect_from_forgery with: :exception

end
