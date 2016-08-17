module Nameable
  extend ActiveSupport::Concern

  included do
    validates :name, :presence => true
  end

  def self.by_name
    order(:name => 'ASC')
  end

  def to_s
    name
  end

end
