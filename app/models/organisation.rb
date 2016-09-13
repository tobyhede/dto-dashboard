class Organisation < ApplicationRecord
  include Nameable
  include Authenticatable

  has_many :dashboards
  has_many :datasets

  validates :url, :presence => true

end
