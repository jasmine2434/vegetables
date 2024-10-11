# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
# movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# Character.create(name: 'Luke', movie: movies.first)

tomato = User.find_or_create_by!(email: "tomato@example.com") do |user|
  user.name = "tomato"
  user.password = "tomato"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/character_tomato.png"), filename:"character_tomato.png")
end

jagaimo = User.find_or_create_by!(email: "jagaimo@example.com") do |user|
  user.name = "jagaimo"
  user.password = "jagaimo"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/jagaimo_hori.png"), filename:"jagaimo_hori.png")
end

retasu = User.find_or_create_by!(email: "retasu@example.com") do |user|
  user.name = "retasu"
  user.password = "retasu"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/character_lettuce.png"), filename:"character_lettuce.png")
end

Vegetable.find_or_create_by!(name: "ラブリーさくら") do |tomato|
  tomato.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/food_puchitomato.png"), filename:"food_puchitomato.png")
  tomato.body = "糖度が高く、甘みと酸味のバランスがいいです。"
  vegetable.user = とま子
end


genre_names = ["野菜", "果物", "農具", "畑", "有機", "その他"]
  genre_names.each do |name|
    Genre.find_or_create_by!(name: name)
  end