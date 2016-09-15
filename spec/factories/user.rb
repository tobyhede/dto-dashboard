FactoryGirl.define do
  factory :user do
    id { rand(30) }
    email { 'test@digital.gov.au' }
    password { '123456' }
  end
end
