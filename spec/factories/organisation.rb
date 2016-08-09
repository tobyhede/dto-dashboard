FactoryGirl.define do
  factory :organisation do
    sequence(:name) { |n| "organisation-#{n}" }
    url      'gov.au'
  end
end
