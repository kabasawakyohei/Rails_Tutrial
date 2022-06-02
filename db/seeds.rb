User.create!(name: "磯野かつお",
             email: "katuo@gmail.com",
            password: "katuo111",
            password_confirmation: "katuo111",
            admin: true)

# 追加のユーザーをまとめて生成する
99.times do
  name = Faker::JapaneseMedia::OnePiece.character
  email = Faker::Internet.unique.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
              password_confirmation: password)
end
