　　　　　　　　![site-logo](https://user-images.githubusercontent.com/86665594/143163730-65ba7f28-0f2c-4ef6-97c9-bf3b7b07ba4c.png)
               ![アセット 1](https://user-images.githubusercontent.com/86665594/143386695-709d7255-97cc-42de-a799-d8ad7d2e0ed1.png)

#　サイトコンセプト
転職用のポートフォリオ制作の一環として一からサービスを立ち上げることを想定して作成しました。
日本人になじみの深い「囲炉裏(いろり)」とボードゲーム界隈の「卓を囲む」という呼び方から着想を得て、
「色んなボードゲームゲーム」を「色んな人」に「色んな時間」に遊んでもらえるように「IRORI」と命名しました。

## サイト概要
オンラインでマッチングしたユーザーと一緒にボードゲームを楽しめるコミュニティサイトです。  
※募集するユーザーはGM(ゲームマスター)と言って、遊ぶ予定のボードゲーム or シナリオの説明役だと考えてください。  
　その為、募集する際は対象のボードゲームのルールに精通している必要があります。

### URL
**※サイトの使い方については「設定」→「ヘルプ」を確認してください。**  
https://irori.work/  
|ユーザー|ログイン方法|
|:---|:---|  
|ゲスト|ボタン一つでログイン可能です|
|テスト|メールアドレス：test@test.com<br>パスワード：test111|

### サイトテーマ
　昔から日本では囲炉裏(いろり)と呼ばれる屋内の床を四角に仕切って火をたき、人々はそこで暖を取っていたと言います。今では囲炉裏を囲んで暖を取る光景も珍しくなりましたが、オンラインで囲炉裏を囲むかのように誰かと一緒に卓を囲むことでボードゲームの楽しさを知ってほしい、人と人とのコミュニケーションによって心を温めてほしいと思いを込めて作成したコミュニティサイトです。

### テーマを選んだ理由
　コロナ禍では外出することが制限され、特に1人暮らしの場合、家に1人で引きこもることを余儀なくされました。私自身、休みの日も外出もできず友人にも会えない日々が続くと、孤独を感じる機会が増えていきました。
そうした中でオンラインでボードゲームができると知って、試しにやってみると顔も名前も全く知らない人とボードゲームを楽しんだり、会話できるという環境が孤独を解消してくれることを知りました。  
　誰かと話したいけどきっかけがない、外出できず孤独を感じている、そんな方が気軽に一歩踏み出せるようなアプリを作ろうと思い立ちました。

### ターゲットユーザー
* ボードゲームを通して誰かと繋がりたい方  
* ボードゲームをやったことがなく、機会があればやってみたいという方  
* ボードゲームが好きで人と遊ぶことが好きな方  
* 煩わしいスケジュール管理から解放されたい方  
* 募集窓口を一本化して、リマインドなどを自動で送信してほしい方

### 主な利用シーン
* おうち時間をボードゲームで楽しみたい時  
* ちょっとしたスキマ時間にボードゲームで遊んでみたい時  
* 誰かと会話しながらボードゲームを楽しみたい時  
* 自分の推しボードゲームを誰かに勧めたい時 

### 機能一覧
* 募集機能
* 予約機能
* 通知機能
  * フォローされた時、DMが届いた時、募集にコメントがあった時、予約された時、予約キャンセルされた時、卓報告で評価された時に通知が来る
* 定時処理
  * 予約確定後、参加者全員のDMにリマインドを送信  
    * 今日の募集の場合はすぐにリマインドを送信  
    * 今日以降の募集の場合は前日の午前8時にリマインドを送信
  * 開始日時が過ぎた募集を自動でクローズする
* 問い合わせ機能  
* 検索機能
* レビュー機能（お世話になったGM/PLにお礼を伝える）
* フォローフォロワー機能
* カレンダー表示（募集・予約状況を表示）
* DM機能
* コメント機能
* レスポンシブ

## ER図
![IRORI_ER drawio](https://user-images.githubusercontent.com/86665594/143388201-0dbebcd0-3cc6-4751-a137-32335f64c375.png)

## 環境・使用技術
### フロントエンド
* SCSS（BEM）
* Javascript、jQuery、Ajax

### バックエンド
* Ruby 2.6.3
* Rails 5.2.5

### 開発環境
* OS：Linux(CentOS)
* 言語：HTML,CSS,JavaScript,Ruby,SQL
* フレームワーク：Ruby on Rails
* JSライブラリ：jQuery
* IDE：Cloud9

### 本番環境
* AWS（EC2、EIP、RDS、Route53）
* MySQL2
* Nginx、Puma

### その他使用技術
* 非同期通信（フォロー・予約・予約キャンセル・コメント・DM・画像アップロードの即時反映）
* 無限スクロール
* インクリメンタルサーチ
* Action Mailer
* whenever（定時処理）
* 外部API（News API）
* Rubocop-airbnb
* HTTPS接続（Certbot）

## 使用素材
- https://booth.pm/ja
- https://boardgamearena.com/
- https://o-dan.net/ja/
