class Widget < ApplicationRecord
  self.inheritance_column = :_type_disabled

  belongs_to :dashboard

  has_many :dataset_widgets
  has_many :datasets, :through => :dataset_widgets

  validates :size, :type, :units, :presence => true

  validates :size, inclusion: { in: %w(extra-small small medium large extra-large),
      message: "%{value} is not a valid size" }

  validates :type, inclusion: { in: %w(bar fact full kpi-sparkline line pie sparkline),
      message: "%{value} is not a valid chart type" }

  validates :units, inclusion: { in: %w(% $ n),
      message: "%{value} is not a valid unit" }

  validates :row, :pos, :presence => true, :numericality => { :only_integer => true }

end
