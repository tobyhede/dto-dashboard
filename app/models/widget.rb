class Widget < ApplicationRecord
  include Nameable
  include Measurable

  self.inheritance_column = :_type_disabled

  belongs_to :dashboard

  has_many :dataset_widgets
  has_many :datasets, :through => :dataset_widgets
  has_many :datapoints, :through => :datasets

  HERO = 'Hero'
  KPIS = ['User Satisfaction', 'Cost per Transaction', 'Digital Take Up', 'Completion Rate']

  validates :size, :type, :presence => true

  validates :size, inclusion: { in: %w(extra-small small medium large extra-large),
      message: "%{value} is not a valid size" }

  validates :type, inclusion: { in: %w(bar fact full kpi-sparkline line pie sparkline),
      message: "%{value} is not a valid chart type" }

  validates :row, :pos, :presence => true, :numericality => { :only_integer => true }

  def element_id
    "widget-#{name.parameterize }"
  end

  def multiple?
    datasets.many?
  end

  def self.hero
    where(:name => HERO)
  end

  def self.kpis
    where(:name => KPIS)
  end

  def self.other
    where.not(:name => KPIS).where.not(:name => HERO)
  end

  def self.by_row
    order(:row => 'ASC')
  end

  def self.by_pos
    order(:pos => 'ASC')
  end

  def has_data?
    datapoints.any?
  end

  def dataset
    datasets.first
  end

end
