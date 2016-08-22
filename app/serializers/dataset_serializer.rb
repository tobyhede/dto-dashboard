class DatasetSerializer < ActiveModel::Serializer
  attributes :id, :name, :units, :data

  # belongs_to :widget
  # has_many :datapoints

  def data
    object.datapoints.collect do | datapoint |
      puts datapoint
      # serializer = DatapointSerializer.new(datapoint)
      # ActiveModelSerializers::Adapter::Json.new(serializer).as_json
    end
  end
end
