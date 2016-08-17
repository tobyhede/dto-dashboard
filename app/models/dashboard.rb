class Dashboard < ApplicationRecord
  include Nameable

  belongs_to :organisation
  has_many :widgets

  def self.published
    where('published_at <= NOW()')
  end

  def rows
    widgets.by_row.by_pos.inject([]){ | a, w|
      a[w.row] = [] unless a[w.row]
      a[w.row] << w
      a
    }
  end

end
