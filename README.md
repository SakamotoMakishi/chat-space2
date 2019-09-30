# どんなアプリ？
画像投稿型のSNSアプリです。

# URL
https://chatapplismks.herokuapp.com

# 開発環境
Ruby、JavaScript、Ruby on Rails、VScode、PostgreSQL、MacOS

# 使い方概説
- テストユーザーの方はログイン画面のかんたんログインよりログインください。

# 実装した機能

- ユーザ新規登録
- ユーザログイン・ログアウト機能
- ユーザかんたんログイン機能
- 複数枚画像投稿(ストレージ:AWS S3, アップローダー:active strage)
- タグ付け機能（tag-it.js,acts-as-taggable-on使用）
- 投稿の編集、削除機能
- 画像拡大機能（luminous.js使用）
- フォロー機能（Ajaxによる非同期通信）
- お気に入り機能（Ajaxによる非同期通信）
- リツイート機能（Ajaxによる非同期通信）
- 投稿へのコメント機能（Ajaxによる非同期通信）
- メッセージ送信機能（Ajaxによる非同期通信)
- ヘッダーサイドバーの解説チュートリアル（chardin.js使用）
- 一部スクロールでページネーション自動ロード（infinite-scroll.js,gem'kaminari'使用）
- weatherAPIから天気情報の取得（広告ブロック等で表示されない可能性あり）
- ログインユーザーに対するエンゲージメント機能（「ある投稿に対してどれくらいのエンゲージ（反応：お気に入り、リツイート、フォローなど）があったかを計る指標、折れ線グラフで表示）
- ユーザーのオンライン状態,ログイン履歴表示（ActionCable使用）

実装期間 : 24日間, 200時間ほど


## usersテーブル

|Column           |Type    |Options                         |
|-----------------|--------|--------------------------------|
|nickname         |string  |null: false                     |
|email            |string  |null: false,unique: true        |
|password         |string  |null: false                     |
|online           |boolean |default: false                  |
|online_at        |datetime|                                |
|profile          |text    |default: "", null: fals         |
|created_at       |datetime   |null: false                  |
|updated_at       |datetime   |null: false                  |

### Association
- has_many :members
- has_many :groups, through: :members
- has_many :messages
- has_many :posts
- has_many :relationships
- has_many :followings, through: :relationships, source: :follow
- has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
- has_many :followers, through: :reverse_of_relationships, source: :user
- has_many :likes, dependent: :destroy
- has_many :like_stories, through: :likes, source: :post
- has_many :retweets, dependent: :destroy
- has_many :retweets_posts, through: :retweets, source: :post
- has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
- has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

## postsテーブル

|Column           |Type       |Options                         |
|-----------------|-----------|--------------------------------|
|title            |string     |null: false                     |
|text             |string     |null: false                     |
|user_id          |integer    |null: false                     |
|likes_count      |integer    |                                |
|retweets_count   |integer    |                                |
|created_at       |datetime   |null: false                     |
|updated_at       |datetime   |null: false                     |

### Association
- has_many :retweets, dependent: :destroy
- has_many :retweets_users, through: :retweets, source: :user
- has_many :likes, dependent: :destroy
- has_many :liking_users, through: :likes, source: :user
- has_many :comments,foreign_key: :post_id, dependent: :destroy
- has_many :notifications,dependent: :destroy

## groupsテーブル

|Column           |Type       |Options                         |
|-----------------|-----------|--------------------------------|
|name             |string     |                                |
|created_at       |datetime   |null: false                     |
|updated_at       |datetime   |null: false                     |


### Association
- has_many :members
- has_many :users, through: :members
- has_many :messages
- has_many :notifications,dependent: :destroy

## membersテーブル

|Column           |Type       |Options                         |
|-----------------|-----------|--------------------------------|
|group_id         |integer    |                                |
|user_id          |integer    |                                |
|created_at       |datetime   |null: false                     |
|updated_at       |datetime   |null: false                     |

### Association
- belongs_to :group
- belongs_to :user

## messagesテーブル

|Column           |Type       |Options                         |
|-----------------|-----------|--------------------------------|
|content          |text       |                                |
|group_id         |integer    |                                |
|user_id          |integer    |                                |
|created_at       |datetime   |null: false                     |
|updated_at       |datetime   |null: false                     |

### Association
- belongs_to :group
- belongs_to :user

## likesテーブル

|Column           |Type       |Options                         |
|-----------------|-----------|--------------------------------|
|user_id          |integer    |                                |
|post_id          |integer    |                                |
|created_at       |datetime   |null: false                     |
|updated_at       |datetime   |null: false                     |

### Association
- belongs_to :post, counter_cache: :likes_count
- belongs_to :user

## retweetsテーブル

|Column           |Type       |Options                         |
|-----------------|-----------|--------------------------------|
|user_id          |integer    |                                |
|post_id          |integer    |                                |
|created_at       |datetime   |null: false                     |
|updated_at       |datetime   |null: false                     |

### Association
- belongs_to :post, counter_cache: :retweets_count
- belongs_to :user

## relationshipsテーブル

|Column           |Type       |Options                         |
|-----------------|-----------|--------------------------------|
|user_id          |integer    |                                |
|post_id          |integer    |                                |
|created_at       |datetime   |null: false                     |
|updated_at       |datetime   |null: false                     |

### Association
- belongs_to :user
- belongs_to :follow, class_name: 'User'

## commentsテーブル

|Column           |Type       |Options                         |
|-----------------|-----------|--------------------------------|
|user_id          |integer    |                                |
|post_id          |integer    |                                |
|comment          |text       |                                |
|created_at       |datetime   |null: false                     |
|updated_at       |datetime   |null: false                     |

### Association
- belongs_to :post,optional: true
- belongs_to :user,optional: true

## notificationsテーブル

|Column           |Type       |Options                         |
|-----------------|-----------|--------------------------------|
|visiter_id       |integer    |                                |
|visited_id       |integer    |                                |
|group_id         |integer    |                                |
|post_id          |integer    |                                |
|message_id       |integer    |                                |
|comment_id       |integer    |                                |
|action           |string     |                                |
|checked          |boolean    |default: false                  |
|created_at       |datetime   |null: false                     |
|updated_at       |datetime   |null: false                     |

### Association
- belongs_to :visiter, class_name: 'User'
- belongs_to :visited, class_name: 'User'
- belongs_to :post, optional: true
- belongs_to :group, optional: true
 
## tagsテーブル(acts-as-taggable-onによる作成)

|Column           |Type       |Options                         |
|-----------------|-----------|--------------------------------|
|name             |string     |                                |
|created_at       |datetime   |null: false                     |
|updated_at       |datetime   |null: false                     |

## taggingsテーブル(acts-as-taggable-onによる作成)

|Column           |Type       |Options                         |
|-----------------|-----------|--------------------------------|
|tag_id           |integer    |                                |
|taggable_type    |string     |                                |
|taggable_id      |integer    |                                |
|tagger_type      |string     |                                |
|tagger_id        |integer    |                                |
|context          |string     |limit: 128                      |
|created_at       |datetime   |null: false                     |
|updated_at       |datetime   |null: false                     |

