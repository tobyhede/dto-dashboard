class ApplicationController < ActionController::Base

  http_basic_authenticate_with :name => ENV['HTTP_BASIC_USERNAME'], :password => ENV['HTTP_BASIC_PASSWORD'] if ENV['HTTP_BASIC_AUTH']

  protect_from_forgery with: :exception

end
