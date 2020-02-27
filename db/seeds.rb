User.create!(
  name: Settings.seeds.name,
  email: Settings.seeds.email,
  password: Settings.seeds.password,
  password_confirmation: Settings.seeds.password_confirmation,
  admin: Settings.seeds.admin,
  activated: Settings.seeds.activated,
  activated_at: Time.zone.now
)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n}@railstutorial.org"
  password = Settings.seeds.password
  User.create!( 
    name:  name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: Settings.seeds.activated,
    activated_at: Time.zone.now
  )
end

users = User.order(:created_at).take(6)

50.times do
  content = Faker::Lorem.sentence word_count: 5
  users.each { |user| user.microposts.create! content: content }
end