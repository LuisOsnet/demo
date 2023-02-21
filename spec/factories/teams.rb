FactoryBot.define do
  factory :team do
    name { Faker::Company.name }
    account_id { nil }
  end
end
