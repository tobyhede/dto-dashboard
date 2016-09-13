FactoryGirl.define do
  factory :dataset do
    organisation
    sequence(:name) { |n| "dataset-#{n}" }
    units '$'

    factory :dataset_with_datapoints do
      transient do
        datapoints_count 10
      end

      after(:create) do |dataset, evaluator|
        create_list(:datapoint, evaluator.datapoints_count, dataset: dataset)
      end
    end

    factory :dataset_with_token do
      transient do
        count 1
      end
      
      after(:create) do |dataset, evaluator|
        dataset.token  << create_list(:token, evaluator.count)
        dataset.save!
      end
    end
  end
end
