class DatasetSerializer < ActiveModel::Serializer
  attributes :id, :name, :units, :notes, :data

  has_many :datapoints
  has_many :widgets

  def id
    object.name.parameterize
  end

  def data
    object.datapoints.collect do |datapoint|
      DatapointSerializer.new(datapoint)
    end
  end
end
