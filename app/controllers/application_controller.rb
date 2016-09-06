class ApplicationController < ActionController::Base

  http_basic_authenticate_with :name => ENV['HTTP_BASIC_USERNAME'], :password => ENV['HTTP_BASIC_PASSWORD'] if (Rails.env.cloudfoundry? || Rails.env.staging?)

  protect_from_forgery with: :exception

end
