class Dataset < ApplicationRecord
  belongs_to :organisation
  has_many :dataset_widgets
  has_many :widgets, :through => :dataset_widgets
  has_many :datapoints
end
