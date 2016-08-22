class DatasetSerializer < ActiveModel::Serializer
  attributes :id, :name, :units, :datapoints, :data

  has_many :datapoints
  has_many :widgets

  def data
    object.datapoints.collect do |datapoint|
      DatapointSerializer.new(datapoint)
    end
  end
end
