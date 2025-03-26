# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | --------------------------|
| nick_name          | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| first_name         | string | null: false               |
| family_name        | string | null: false               |
| first_name_kana    | string | null: false               |
| family_name_kana   | string | null: false               |
| birthday           | integer| null: false               |

### Association

- has_many :items
- has_many :comments
- has_many :shippings
- has_many :purchases



## itemsテーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| item_name            | string     | null: false                    |
| description          | text       | null: false                    |
| category             | integer    | null: false                    |
| condition            | integer    | null: false                    |
| shipping_cost        | integer    | null: false                    |
| shipping _from_region| integer    | null: false                    |
| days_to_ship         | integer    | null: false                    |
| price                | integer    | null: false                    |
| user                 | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments
- has_one :shippings
- has_one :purchases

### 備考
- Column:user、Type:referencesとするとuserテーブルからuser.idをとってきてくれる
- imageはActiveStorageで実装するため含まない



## shippingsテーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| zip_code             | integer    | null: false                    |
| prefecture           | integer    | null: false                    |
| city                 | text       | null: false                    |
| street_address       | text       | null: false                    |
| building             | text       |                                |
| phone_number         | integer    | null: false                    |
| user                 | references | null: false, foreign_key: true |
| item                 | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item



## purchasesテーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| user                 | references | null: false, foreign_key: true |
| item                 | references | null: false, foreign_key: true |
| shipping             | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :shippings



## comments テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| comment   | text       | null: false                    |
| item      | references | null: false, foreign_key: true |
| user      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item