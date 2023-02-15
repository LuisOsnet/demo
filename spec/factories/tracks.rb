FactoryBot.define do
  factory :track do
    trackable_id { 1 }
    trackable_type { "MyString" }
    user_id { "MyString" }
    team_id { "MyString" }
    started_at { "2023-02-15 07:15:34" }
    ended_at { "2023-02-15 07:15:34" }
  end
end
