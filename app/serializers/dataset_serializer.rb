class DatasetSerializer < ActiveModel::Serializer
  attributes :id, :name, :units, :notes, :data, :color

  has_many :datapoints
  has_many :widgets

  def color
    "#5261c9"
  end

  def data
    object.datapoints.collect do |datapoint|
      DatapointSerializer.new(datapoint)
    end
  end
end
