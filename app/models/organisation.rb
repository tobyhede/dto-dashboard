class Organisation < ApplicationRecord
  has_many :dashboards
  has_many :datasets

  validates :name, :url, :presence => true
end
