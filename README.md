# Fit Care Health

自身のやっているヘルスケアやメディカルケアの方法を投稿できるアプリ  
ユーザー同士で健康をシェアすることによって、新しい発見をすることができます。
検索ソート機能などが実装されております。

---
## URL
 https://fit-care-health.com/

<!-- ---
実装した機能についての画像やGIFおよびその説明
実装した機能について、それぞれどのような特徴があるのかを列挙する形で記述。画像はGyazoで、GIFはGyazoGIFで撮影すること。 -->

---
## TOP画像

[![Image from Gyazo](https://i.gyazo.com/f74796ba33b071797f472ece530f410c.gif)](https://gyazo.com/f74796ba33b071797f472ece530f410c)

---
## テスト用アカウント

	ログイン機能
	メールアドレス：test@test
	パスワード：111111
	※ ゲストログインはクリックのみ

---
# 利用方法

新規登録をしてログインをしたら投稿やコメント、いいねができる。  
ゲストユーザーは投稿やコメント、いいねはできない。

---
# 目指した課題解決

前職でお客様に接客をさせていただいた際、普段の生活習慣や管理方法を変えることで、薬を飲むなどの対処を行う前に、対策ができた内容が多かった経験を踏まえ、このアプリケーションを通じて、普段健康に不安を感じている人や自分の健康管理をしたい方が、知りたい内容を、他のご自身でやられている健康法や生活習慣などを世の中の健康な人を増やしたいと考えている方の知識を共有することで、ご自身の健康的な生活に役立てていけるようにしようとした目的で作ったアプリになります。

---
# 工夫したポイント

インフラ技術としてAWSの機能の一部とDockerやCircleCIを独学で学び導入しました。  
検索機能はヘッダーを持ち入り、どこからでも検索して検索結果のページに遷移できます。  
いいね、フォローはJavaScriptによる非同期通信です。

---
# 使用技術(開発環境)
## フロントエンド
- HTML/CSS
- JavaScript(Ajax)
- Bootstrap 5.0
## バックエンド
- Ruby 2.6.5
- Ruby on Rails 6.1.3
## インフラ
- MySQL 5.6.51
- Nginx
- Unicorn
- AWS (VPC, IAM, EC2, RDS(MySQL), S3, Route53, ALB, ACM, CloudWatch)
- Docker/docker-compose
## チェックツール
- Rspec
- Rubocop
- AWS (Inspector)
- CircleCI

# インフラ構成図
<img width="900" alt="インフラ構成図" src=https://user-images.githubusercontent.com/68750516/122555268-0b0bb600-d075-11eb-827a-95b096ef9325.png>

---
# 機能一覧
## フロントエンド
- ユーザー機能(新規登録、編集、ログイン・ログアウト)
- ゲストユーザー機能(制限機能付き)
- 投稿機能(投稿、一覧、詳細、編集、削除)
- 投稿のヘッダー検索機能／検索結果のソート機能
- コメント機能
- いいね機能(非同期通信)
- フォロー機能(非同期通信)
- タグ機能/タグ検索/検索結果のソート機能

## バックエンド
- 単体テスト機能
- 結合テスト機能
- 自動テスト機能
- 自動静的コード解析

---
# 課題や実装予定の機能
- ページネーション機能
- ユーザー診断機能
- 自動デプロイ機能

---
# データベース設計
## テーブル設計
### users テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| nickname           | string     | null: false                    |
| email              | string     | null: false, unique: true      |
| encrypted_password | string     | null: false                    |
| profile            | text       | null: false                    |
| birthday           | date       | null: false                    |
| status             | references | null: false, foreign_key: true |

#### Association

- has_many :posts
- has_many :comments, dependent: :destroy
- has_many :likes,    dependent: :destroy
- has_many :liked_posts, through: :likes, source: :post
- has_many :following_relationships, foreign_key: 'follower_id', class_name: 'FollowRelationship', dependent: :destroy
- has_many :followings, through: :following_relationships
- has_many :follower_relationships, foreign_key: 'following_id', class_name: 'FollowRelationship', dependent: :destroy
- has_many :followers, through: :follower_relationships
- has_one  :statuses
- has_one_attached :image


### posts テーブル

| Column                | Type       | Options                        |
| --------------------- | ---------- | ------------------------------ |
| title                 | string     | null: false                    |
| catch_copy            | text       | null: false                    |
| concept               | text       | null: false                    |
| user                  | references | null: false, foreign_key: true |

#### Association

- belongs_to  :user
- has_many    :comments, dependent: :destroy
- has_many    :likes,    dependent: :destroy
- has_many    :liked_users, through: :likes, source: :user
- has_one_attached    :image

### comments テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| text      | text       | null: false                    |
| user      | references | null: false, foreign_key: true |
| post      | references | null: false, foreign_key: true |

#### Association

- belongs_to :user
- belongs_to :post

### likes テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| post      | references | null: false, foreign_key: true |

#### Association

- belongs_to :user
- belongs_to :post

### follows テーブル

| Column    | Type       | Options                                             |
| --------- | ---------- | --------------------------------------------------- |
| follower  | references | null: false, foreign_key: true { to_table: :users } |
| following | references | null: false, foreign_key: true { to_table: :users } |

#### Association

- belongs_to :follower,  class_name: 'User'
- belongs_to :following, class_name: 'User'


### tags テーブル

| Column    | Type       | Options         |
| --------- | ---------- | --------------- |
| tag_name  | string     | null: false     |

#### Association

- has_many :tag_maps, dependent: :destroy
- has_many :posts, through: :tag_maps


### tag_maps テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| post      | references | null: false, foreign_key: true |
| tag       | references | null: false, foreign_key: true |

#### Association

- belongs_to :post
- belongs_to :tag

## ER図
<img width="899" alt="ER図" src="https://user-images.githubusercontent.com/68750516/123537425-5eaf8b00-d76a-11eb-80e1-5a574638d98f.png">