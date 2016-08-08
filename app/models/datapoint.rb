class Datapoint < ApplicationRecord
  belongs_to :dataset

  validates :ts, :presence => true

  validates :value, :numericality => true
end
