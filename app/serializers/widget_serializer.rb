class WidgetSerializer < ActiveModel::Serializer
  attributes :id, :name, :type, :size, :latest, :units,
              :definition, :description, :updated_at,
              :prefix, :suffix,
              :stacking, :displayRoundedData

  has_many :datasets, :include => :datapoints

  def definition
    object.description
  end

  def displayRoundedData
    object.options['displayRoundedData'] if object.options
  end

  def stacking
    object.options['stacking'] if object.options
  end

  def latest
    if object.dataset.present? && object.dataset.latest.present?
      DatapointSerializer.new(object.dataset.latest)
    end
  end
end
