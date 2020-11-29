## usersテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| nickname           | string     | null: false                    |
| email              | string     | null: false, unique: true      |
| encrypted_password | string     | null: false                    |
| first_name         | string     | null: false                    |
| last_name          | string     | null: false                    |
| first_name_kana    | string     | null: false                    |
| last_name_kana     | string     | null: false                    |
| birthday           | date       | null: false                    |

### Association
- has_many :items
- has_one :credit_card

## itemsテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user          | references | foreign_key: true              |
| name          | string     | null: false                    |
| detail        | text       | null: false                    |
| category      | string     | null: false                    |
| state         | string     | null: false                    |
| postage       | string     | null: false                    |
| prefecture    | string     | null: false                    |
| shipping_date | integer    | null: false                    |
| price         | integer    | null: false                    |

### Association
- belongs_to: user
- has_one: credit_card

## ordersテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user          | references | foreign_key:true               |
| item          | references | foreign_key:true               |

### Association
- belongs_to :user
- belongs_to :item
- has_one :address

## addressesテーブル

| Column       | Type        | Options                        |
| ------------ | ----------- | ------------------------------ |
| order        | references  | foreign_key: true              |
| zip          | string      | null: false                    |
| prefecture   | string      | null: false                    |
| city         | string      | null: false                    |
| street       | string      | null: false                    |
| apartment    | string      |                                |
| phone        | string      | null: false                    |

### Association
- belongs_to :orders