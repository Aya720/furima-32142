## usersテーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| nickname         | string     | null: false                    |
| email            | string     | null: false                    |
| pwd              | string     | null: false                    |
| first_name       | string     | null: false                    |
| last_name        | string     | null: false                    |
| first_name_kana  | string     | null: false                    |
| last_name_kana   | string     | null: false                    |
| birthday         | integer    | null: false                    |

### Association
- has_many :items
- has_one :credit_card

## itemsテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user          | references | foreign_key: true              |
| image         |            | null: false                    |
| item_name     | string     | null: false                    |
| detail        | text       | null: false                    |
| category      | string     | null: false                    |
| state         | string     | null: false                    |
| postage       | string     | null: false                    |
| region        | string     | null: false                    |
| shipping_date | integer    | null: false                    |
| price         | integer    | null: false                    |

### Association
- belongs_to: user
- has_one: credit_card

## credit_cardsテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user          | references | foreign_key:true               |
| item          | references | foreign_key:true               |
| card_company  | string     | null: false                    |
| card_number   | string     | null: false                    |
| card_year     | integer    | null: false                    |
| card_month    | integer    | null: false                    |
| card_pass     | integer    | null: false                    |

### Association
- belongs_to :user
- belongs_to :item
- has_one :address

## addressesテーブル

| Column       | Type        | Options                        |
| ------------ | ----------- | ------------------------------ |
| zip          | integer     | null: false                    |
| prefecture   | string      | null: false                    |
| city         | string      | null: false                    |
| street       | string      | null: false                    |
| apartment    | string      |                                |
| phone        | string      | null: false                    |

### Association
- belongs_to :credit_card