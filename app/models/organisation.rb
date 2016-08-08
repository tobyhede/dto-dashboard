class Organisation < ApplicationRecord
  include Nameable
  
  has_many :dashboards
  has_many :datasets

  validates :url, :presence => true
end
