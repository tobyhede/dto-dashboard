class Dashboard < ApplicationRecord
  belongs_to :agency
  has_many :widgets

end
