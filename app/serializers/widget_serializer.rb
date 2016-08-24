class WidgetSerializer < ActiveModel::Serializer
  attributes :id, :name, :type, :size, :latest, :units,
              :description, :updated_at, :change,
              :prefix, :suffix, :stacking, :displayRoundedData,
              :definition

  has_many :datasets, :include => :datapoints

  def definition
    object.description
  end

  def displayRoundedData
    true
  end

  def stacking
    'percentage'
  end

  def prefix
    ''
  end

  def suffix
    ''
  end

  def change
    99
  end

  def latest
    if object.dataset.present? && object.dataset.latest.present?
      DatapointSerializer.new(object.dataset.latest)
    end
  end
end
