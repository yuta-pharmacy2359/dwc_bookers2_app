User.create!(name: "横須賀八郎", email: "hachiro.yokosuka@gmail.com", password: "yokosuka", password_confirmation: "yokosuka")

99.times do |n|
  name = Faker::Name.name
  email = "nezuko-#{n+1}@gmail.com"
  password = "password"
  User.create!(name: name, email: email, password: password, password_confirmation: password)
end

users = User.order(:created_at).take(6)
50.times do
  title = Faker::Lorem.sentence(word_count: 5)
  opinion = Faker::Lorem.sentence(word_count: 10)
  users.each {|user| user.books.create!(title: title, body: opinion)}
end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}