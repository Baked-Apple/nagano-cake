# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者
Admin.create(
	email: "admin@mail",
	password: "adminadmin"
	)


Genre.create([{genre: "ケーキ",invalid_status: 0,}, {genre: "プリン",invalid_status: 0,}, {genre: "焼き菓子",invalid_status: 0,}, {genre: "キャンディ",invalid_status: 0,}])

Item.create([
	{genre_id: 1, name: "ティラミス", introduction: "当店おすすめ", price: 400, sale_status: 1, image: open("./db/images/ティラミス.jpg")},
	{genre_id: 1, name: "モンブラン", introduction: "当店おすすめ", price: 400, sale_status: 1, image: open("./db/images/モンブラン.jpg")},
	{genre_id: 2, name: "焼きプリン", introduction: "当店おすすめ", price: 300, sale_status: 1, image: open("./db/images/焼きプリン.jpg")},
	{genre_id: 2, name: "いちごプリン", introduction: "当店おすすめ", price: 300, sale_status: 1, image: open("./db/images/いちごプリン.jpg")},
	{genre_id: 3, name: "バタークッキー", introduction: "当店おすすめ", price: 200, sale_status: 1, image: open("./db/images/バタークッキー.jpg")},
	{genre_id: 3, name: "チョコチップクッキー", introduction: "当店おすすめ", price: 200, sale_status: 1, image: open("./db/images/チョコチップクッキー.jpg")},
	{genre_id: 4, name: "ミルクキャンディ", introduction: "当店おすすめ", price: 200, sale_status: 1, image: open("./db/images/ミルクキャンディ.jpg")},
	{genre_id: 4, name: "フルーツキャンディ", introduction: "当店おすすめ", price: 200, sale_status: 1, image: open("./db/images/フルーツキャンディ.jpg")},
])
