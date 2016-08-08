class Datapoint < ApplicationRecord
  belongs_to :dataset

  validates :ts, :presence => true

  validates :value, :numericality => true

  def label
    ts.strftime("%Y-%m")
  end

  # scope :group_by_month, -> { select("date_trunc('month', ts) as ts, value").group("date_trunc('month', ts)") }

end
