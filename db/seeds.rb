super_user = User.create!(
  name: 'Emmett Hermiston I',
  level_english: 'B1',
  technical_knowledge: 'Ruby on Rails',
  resume_url: 'https://docs.google.com/document/d/1Y4ZCwrgKJ4WV5W109cF4XN20d3Klt7SNCrjQagOhh8E',
  email: 'superuser@mind.com',
  password: 'password',
  password_confirmation: 'password'
)

admin = User.create!(
  name: 'Rhett Schroeder',
  level_english: 'C1',
  technical_knowledge: 'React',
  resume_url: 'https://docs.google.com/document/d/1Y4ZCwrgKJ4WV5W109cF4XN20d3Klt7SNCrjQagOhh8E',
  email: 'admin@mind.com',
  password: 'password',
  password_confirmation: 'password'
)

user = User.create!(
  name: 'Enrique Medhurst',
  level_english: 'B2',
  technical_knowledge: 'Python',
  resume_url: 'https://docs.google.com/document/d/1Y4ZCwrgKJ4WV5W109cF4XN20d3Klt7SNCrjQagOhh8E',
  email: 'user@mind.com',
  password: 'password',
  password_confirmation: 'password'
)

p "Created #{User.count} users"

super_user&.add_role(:super_user)
admin&.add_role(:admin)
user&.add_role(:user)

account = Account.create!(
  name: 'DAOS Water',
  client_name: 'Anais Ziemann',
  owner: 'Blair Purdy'
)

p "Created #{Account.count} accounts"

Team.create!(
  name: 'Back',
  account_id: account&.id
)

p "Created #{Team.count} team"