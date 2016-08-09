class Dashboard < ApplicationRecord
  include Nameable

  belongs_to :organisation
  has_many :widgets
  
  scope :published, -> { where('published_at <= NOW()') }

end
