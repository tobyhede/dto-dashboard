FactoryGirl.define do
  factory :dashboard do
    organisation
    sequence(:name) { |n| "dashboard-#{n}" }
  end
end
