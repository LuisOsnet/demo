FactoryBot.define do
  factory :account do
    name { Faker::Company.name }
    client_name { Faker::Name.unique.name }
    owner { Faker::Name.unique.name }
  end
end
