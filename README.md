# テーブル設計

## users テーブル

| Column             | Type     | Options                   |
| -------------------|----------| --------------------------|
| nick_name          | string   | null: false               |
| email              | string   | null: false, unique: true |
| encrypted_password | string   | null: false               |
| first_name         | string   | null: false               |
| family_name        | string   | null: false               |
| first_name_kana    | string   | null: false               |
| family_name_kana   | string   | null: false               |
| birthday           | date   	| null: false               |

### Association

- has_many :items
- has_many :purchases



## itemsテーブル

| Column                   | Type       | Options                        |
| ------------------------ | ---------- | ------------------------------ |
| item_name                | string     | null: false                    |
| description              | text       | null: false                    |
| category_id              | integer    | null: false                    |
| condition_id             | integer    | null: false                    |
| shipping_cost_id         | integer    | null: false                    |
| prefecture_id            | integer    | null: false                    |
| days_to_ship_id          | integer    | null: false                    |
| price                    | integer    | null: false                    |
| user                     | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase

### 備考
- Column:user、Type:referencesとするとuserテーブルからuser.idをとってきてくれる
- imageはActiveStorageで実装するため含まない



## shippingsテーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| zip_code             | string     | null: false                    |
| prefecture_id        | integer    | null: false                    |
| city                 | string     | null: false                    |
| street_address       | string     | null: false                    |
| building             | string     |                                |
| phone_number         | string     | null: false                    |
| purchase             | references | null: false, foreign_key: true |

### Association
- belongs_to :purchase


## purchasesテーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| user                 | references | null: false, foreign_key: true |
| item                 | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping