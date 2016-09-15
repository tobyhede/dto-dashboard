FactoryGirl.define do
  factory :organisation do
    sequence(:name) { |n| "organisation-#{n}" }
    url      'gov.au'

    factory :organisation_with_token do
      transient do
        count 1
      end

      after(:create) do |organisation, evaluator|
        organisation.tokens << create_list(:token, evaluator.count)
        organisation.save!
      end

    end
  end
end
