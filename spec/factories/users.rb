FactoryBot.define do
  factory :user do
    name { "Jon Doe" }
    level_english { 'C2' }
    technical_knowledge { 'Laravel' }
    resume_url { 'https://docs.google.com/document/d/1Y4ZCwrgKJ4WV5W109cF4XN20d3Klt7SNCrjQagOhh8E' }
    email { 'jon.doe@gmail.com' }
    password { 'jon123' }
    password_confirmation { 'jon123' }
  end
end