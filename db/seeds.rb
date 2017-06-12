User.create! name: "test", email: "test@gmail.com", password: "1234567",
  password_confirmation: "1234567", is_admin: 1,
    activated: true, activated_at: Time.zone.now

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create! name: name, email: email, password: password,
    password_confirmation: password, activated: true, activated_at: Time.zone.now
end
