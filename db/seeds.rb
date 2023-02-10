User.create!(
  [
    {
      name: 'Luis Osnet',
      level_english: 'B1',
      technical_knowledge: 'Ruby on Rails',
      resume_url: 'https://docs.google.com/document/d/1Y4ZCwrgKJ4WV5W109cF4XN20d3Klt7SNCrjQagOhh8E',
      email: 'luisosnet@gmail.com',
      password: 'abc123',
      password_confirmation: 'abc123'
    }
  ]
)

p "Created #{User.count} users"
