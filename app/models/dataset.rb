class Dataset < ApplicationRecord
  include Measurable
  include Nameable

  belongs_to :organisation
  has_many :datapoints
  has_many :widgets, :through => :dataset_widgets
  has_many :dataset_widgets

  def latest
    datapoints.by_time.last
  end

  def previous
    datapoints.by_time.offset(1).last
  end

  def up?
    change > 0
  end

  def down?
    !up?
  end

  def changed?
    change != 0
  end

  def unchanged?
    change == 0
  end

  def change
    latest.value - previous.value
  end

  def trend
    return 'unchanged' if unchanged?
    up? ? 'up' : 'down'
  end

  def has_data?
    datapoints.any?
  end

end
