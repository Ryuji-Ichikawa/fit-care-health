# Fit Care Health

自身のやっているヘルスケアやメディカルケアの方法を投稿できるアプリ  
自身の健康管理をしつつ、必要に応じて栄養素やサプリどのような運動が良いかおすすめしてもらえる機能がある 

![demo](https://i.gyazo.com/adbeb0981bd9c0faac459e87a785330f.gif)


---
<!-- ## URL
	デプロイ済みのURLを記述。デプロイが済んでいない場合は、デプロイが完了次第記述すること。 -->

<!-- ## テスト用アカウント
	ログイン機能等を実装した場合は、ログインに必要な情報を記述。またBasic認証等を設けている場合は、そのID/Passも記述すること。 -->

# 利用方法
新規登録をしてログインをしたら投稿やコメントができる、  
ゲストユーザーは投稿やコメントはできない  

---
# 目指した課題解決

前職でお客様に接客をさせていただいた際、普段の生活習慣や管理方法を変えることで、
薬を飲むなどの対処を行う前に、対策ができた内容が多かった経験を踏まえ、
このアプリケーションを通じて、普段健康に不安を感じている人や自分の健康管理をしたい方が、  
知りたい内容を、他のご自身でやられている健康法や生活習慣などを世の中の健康な人を増やしたいと考えている方の知識を
共有することで、ご自身の健康的な生活に役立てていけるようにしようとした目的で作ったアプリになります。

<!-- ---
# 実装した機能についての画像やGIFおよびその説明
実装した機能について、それぞれどのような特徴があるのかを列挙する形で記述。画像はGyazoで、GIFはGyazoGIFで撮影すること。 -->

---
# 工夫したポイント

インフラ技術としてDockerやCircleCIを独学で学び導入しました。

---
# 使用技術(開発環境)
- フロントエンド
	- HTML/CSS
	- JavaScript
	- Bootstrap 5.0
- バックエンド
	- Ruby 2.6.5
	- Ruby on Rails 6.1.3
	- Rspec
	- Rubocop
- インフラ
	- MySQL 5.6.51
	- AWS (EC2, IAM, S3, VPC) <!--, Route53, ALB, ACM, RDS for MySQL,) -->
	- Docker/docker-compose
	- CircleCI

---
# 機能一覧
## フロントエンド
- ユーザー機能(新規登録、ログイン・ログアウト)
- ゲストユーザー機能(制限機能付き)
- 投稿機能(投稿、一覧、詳細、編集、削除)
- コメント機能
- いいね機能(非同期通信)

## バックエンド
- 単体テスト機能
- 結合テスト機能
- DBテーブルのリレーション機能
- DBトランザクション機能
- 自動テスト機能
- 自動デプロイ機能

---
# 課題や実装予定の機能
- ページネーション機能
- フォロー機能
- ユーザー診断機能

---
# データベース設計
<img width="900" alt="5fa8f0cae8b9169976949c272499c7c9" src="https://user-images.githubusercontent.com/68750516/119324811-33450680-bcbb-11eb-99e9-18fca609e98c.png">

# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| profile            | text   | null: false               |
| birthday           | date   | null: false               |

### Association

- has_many :posts
- has_many :comments, dependent: :destroy
- has_many :likes,    dependent: :destroy
- has_many :liked_posts, through: :likes, source: :post
- has_many :follows
- has_one  :statuses
- has_one_attached :image


## posts テーブル

| Column                | Type       | Options                        |
| --------------------- | ---------- | ------------------------------ |
| title                 | string     | null: false                    |
| catch_copy            | text       | null: false                    |
| concept               | text       | null: false                    |
| user                  | references | null: false, foreign_key: true |

### Association

- belongs_to  :user
- has_many    :comments, dependent: :destroy
- has_many    :likes,    dependent: :destroy
- has_many    :liked_users, through: :likes, source: :user
- has_one_attached    :image

## comments テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| text      | text       | null: false                    |
| user      | references | null: false, foreign_key: true |
| post      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :post

## likes テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| post      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :post

## follows テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| post      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :post

## tags テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| post      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :post

## tag_maps テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| post      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :post