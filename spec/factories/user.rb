FactoryGirl.define do
  factory :user do
    id { rand(30) }
    email { 'dev@localhost' }
    password { 'password' }
    password_confirmation { "password" }
    confirmed_at Date.today
  end
end
