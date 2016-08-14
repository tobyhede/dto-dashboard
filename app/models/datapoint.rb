class Datapoint < ApplicationRecord
  belongs_to :dataset

  validates :ts, :presence => true

  validates :value, :numericality => true, :allow_nil => true

  scope :by_time, -> { order(:ts => 'DESC') }

  def label
    ts.strftime("%Y-%m")
  end

end
