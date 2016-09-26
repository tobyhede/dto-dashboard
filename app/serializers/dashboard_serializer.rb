class DashboardSerializer < ActiveModel::Serializer
  attributes  :name,
              :description,
              :target_users,
              :notes,
              :url,
              :published_at
  
end
