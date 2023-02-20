FactoryBot.define do
  factory :user do
    name { "Jon Doe" }
    level_english { 'C2' }
    technical_knowledge { 'Laravel' }
    resume_url { 'https://docs.google.com/document/d/1Y4ZCwrgKJ4WV5W109cF4XN20d3Klt7SNCrjQagOhh8E' }
    email { 'jon.doe@gmail.com' }
    password { 'jon123' }

    trait :super_user do
      after(:create) {|user| user.add_role(:super_user)}
    end

    trait :admin do
      after(:create) {|user| user.add_role(:admin)}
    end

    trait :user do
      after(:create) {|user| user.add_role(:user)}
    end

  end
end