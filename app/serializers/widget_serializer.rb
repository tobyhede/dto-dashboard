class WidgetSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :datasets

end
