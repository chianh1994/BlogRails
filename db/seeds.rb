User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

31.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(4)
16.times do
  title = Faker::Book.title
  content = Faker::Lorem.sentence(4)
  users.each { |user| user.entries.create!(content: content,
    title: title) }
end

users = User.all
user  = users.first
following = users[2..16]
followers = users[3..8]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

users = User.order(:created_at).take(4)
entries = Entry.order(:created_at).take(8)
  entries.each do |entry|
    users.each do |user|
      content = Faker::Lorem.sentence(1)
      entry.comments.create!(content: content, user_id: user.id)
    end
  end
