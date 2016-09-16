module HttpBasicate
  extend ActiveSupport::Concern

  included do
    http_basic_authenticate_with :name => ENV['HTTP_BASIC_USERNAME'], :password => ENV['HTTP_BASIC_PASSWORD'] if (Rails.env.cloudfoundry? || Rails.env.staging?)
  end

end
