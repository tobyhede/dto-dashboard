class WidgetSerializer < ActiveModel::Serializer
  attributes :id, :name, :type, :size, :latest, :units,
              :definition, :description, :updated_at,
              :prefix, :suffix,
              :stacking

  attribute   :displayRoundedData, :if => :displayRoundedData?
  attribute   :stacking, :if => :stacking?

  has_many :datasets, :include => :datapoints

  def definition
    object.description
  end

  def displayRoundedData?
    object.options && object.options.key?('displayRoundedData')
  end

  def displayRoundedData
    object.options['displayRoundedData']
  end

  def stacking?
    object.options && object.options.key?('stacking')
  end

  def stacking
    object.options['stacking']
  end

  def latest
    if object.dataset.present? && object.dataset.latest.present?
      DatapointSerializer.new(object.dataset.latest)
    end
  end
end
