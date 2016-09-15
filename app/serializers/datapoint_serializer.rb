class DatapointSerializer < ActiveModel::Serializer
  attributes :id, :ts, :value, :label, :created_at, :updated_at

end
