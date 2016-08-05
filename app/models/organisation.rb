class Organisation < ApplicationRecord
  has_many :dashboards
  has_many :datasets
end
