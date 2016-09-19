class Dashboard < ApplicationRecord
  include Nameable

  belongs_to :organisation

  has_many :widgets

  has_many :datasets, :through => :widgets

  has_and_belongs_to_many :users

  def self.published
    where('published_at <= NOW()')
  end

  def hero
    widgets.hero.first
  end

  def rows
    @rows ||= widgets.without_hero.by_row.by_pos.inject([]){ | a, w|
      a[w.row] = [] unless a[w.row]
      a[w.row] << w
      a
    }.compact
  end

  def first_row
    rows.first
  end

  def remaining_rows
    rows.drop(1)
  end

  def to_param
    @slug ||= "#{id}-#{name.parameterize}"
  end

  def last_updated_at
    widgets.last_updated.last_updated_at
  end
end
