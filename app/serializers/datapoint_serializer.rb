class DatapointSerializer < ActiveModel::Serializer
  attributes :value, :label

  # belongs_to :dataset

end
