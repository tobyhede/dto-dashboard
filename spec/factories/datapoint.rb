FactoryGirl.define do
  factory :datapoint do
    ts      { rand(30).months.ago }
    value   { rand(100000) }
  end
end
