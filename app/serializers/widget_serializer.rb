class WidgetSerializer < ActiveModel::Serializer
  attributes :id, :name, :type, :size, :units, :description, :updated_at, :datasets

  has_many :datasets, :include => :datapoints

end
