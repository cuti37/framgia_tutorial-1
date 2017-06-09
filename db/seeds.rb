User.create! name: "test", email: "test@gmail.com", password: "1234567",
  password_confirmation: "1234567", is_admin: 1

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create! name: name, email: email, password: password,
    password_confirmation: password
end
