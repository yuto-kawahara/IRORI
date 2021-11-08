# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
EntryCondition.create!(
  [
    {
      name: "初心者歓迎",
      introduction: "初心者の方も安心してご参加ください。"
    },
    {
      name: "多弁禁止",
      introduction: "1人のプレイヤーが話しすぎると議論が進みませんのでご注意ください。"
    },
    {
      name: "強弁禁止",
      introduction: "キツイ言葉を投げかけるのは控えてください。"
    },
    {
      name: "PC環境(必須)",
      introduction: "PC環境で遊ぶことを推奨しています。"
    },
    {
      name: "推奨ブラウザ(Chrome)",
      introduction: "ブラウザはChromeを推奨しています。"
    },
    {
      name: "イヤホン/ヘッドセット(必須)",
      introduction: "イヤホン/ヘッドセットが必要になります。"
    },
    {
      name: "キャンセル無効",
      introduction: "やむを得ない場合以外のキャンセルは無効となります。"
    },
    {
      name: "マナー重視",
      introduction: "あくまでもゲームを楽しむ場なので感情的にならず皆で楽しもうとする気持ちが必要です。"
    }
  ])

PlayForm.create!(
  [
    {
      name: "Discord",
      introduction: ""
    },
    {
      name: "ボードゲームアリーナ",
      introduction: ""
    },
    {
      name: "ユドナリウム",
      introduction: ""
    },
    {
      name: "ココフォリア",
      introduction: ""
    },
    {
      name: "その他",
      introduction: ""
    }
  ])

user = User.new(
  email: "shimeji@test.com",
  nickname: "舞茸しめじ",
  introduction: "よろしくお願いいたします",
  password: "test123",
  )
user.save!

user = User.new(
  email: "matutake@test.com",
  nickname: "まつたけえのき",
  introduction: "よろしくお願いいたします",
  password: "test456",
  )
user.save!

user = User.new(
  email: "hiratake@test.com",
  nickname: "平茸なめこ",
  introduction: "よろしくお願いいたします",
  password: "test789",
  )
user.save!

user = User.new(
  email: "buna@test.com",
  nickname: "ブナシメジ",
  introduction: "よろしくお願いいたします",
  password: "test101",
  )
user.save!

user = User.new(
  email: "kaen@test.com",
  nickname: "カエンダケ",
  introduction: "よろしくお願いいたします",
  password: "test111",
  )
user.save!

user = User.new(
  email: "tengu@test.com",
  nickname: "テングダケ",
  introduction: "よろしくお願いいたします",
  password: "test121",
  )
user.save!


100.times do |n|
  Recruit.create!(
    user_id: 1,
    title: "マダミス#{n}",
    start_time: "2021-11-07 02:11:00",
    time_required: 2,
    capacity: 1,
    explanation: "募集中です",
    discord_server_link: "https://discord"
  )

end
100.times do |n|
  Recruit.create!(
    user_id: 2,
    title: "ボドゲ#{n}",
    start_time: "2021-11-08 02:11:00",
    time_required: 4,
    capacity: 1,
    explanation: "募集中です",
    discord_server_link: "https://discord"
  )

end
