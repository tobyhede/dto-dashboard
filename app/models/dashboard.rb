class Dashboard < ApplicationRecord
  belongs_to :organisation
  has_many :widgets

  validates :name, :presence => true

  scope :published, -> { where('published_at <= NOW()') }
  scope :by_name, -> { order(:name => 'DESC') }

end
