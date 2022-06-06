User.create!(name: "磯野かつお",
             email: "katuo@gmail.com",
            password: "katuo111",
            password_confirmation: "katuo111",
            admin: true,
            activated: true,
            activated_at: Time.zone.now)

# 追加のユーザーをまとめて生成する
99.times do
  name = Faker::JapaneseMedia::OnePiece.character
  email = Faker::Internet.unique.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)
end

# ユーザーの一部を対象にツイートを生成する
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.tweets.create!(content: content)}
end