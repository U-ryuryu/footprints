## admins

| Column                    | Type   | Options                   |
| ------------------------- | ------ | ------------------------- |
| name                      | string | null: false               |
| email                     | string | null: false, unique: true |
| encrypted_password        | string | null: false               |

### Association

- has_many :users
- has_many :clients

## users

| Column                    | Type       | Options                        |
| ------------------------- | ---------- | ------------------------------ |
| name                      | string     | null: false                    |
| email                     | string     | null: false, unique: true      |
| encrypted_password        | string     | null: false                    |
| admin                     | references | null: false, foreign_key: true |

### Association

- belongs_to :admin
- has_many   :visits
- has_many   :calls
- has_many   :visit_comment
- has_many   :call_comment

## clients

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| name             | string     | null: false                    |
| tel              | string     | null: false                    |
| postal_code      | string     | null: false                    |
| address          | integer    | null: false                    |
| charge           | integer    |                                |
| charge_tel       | integer    |                                |
| admin            | references | null: false, foreign_key: true |

### Association

- belongs_to :admin
- has_one    :visits
- has_one    :calls

## visits

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| title            | string     | null: false                    |
| content          | string     | null: false                    |
| status_id        | string     | null: false                    |
| user             | references | null: false, foreign_key: true |
| client           | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :client

## calls

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| title            | string     | null: false                    |
| content          | string     | null: false                    |
| status_id        | string     | null: false                    |
| user             | references | null: false, foreign_key: true |
| client           | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :client

## visit_comments

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| title            | string     | null: false                    |
| user             | references | null: false, foreign_key: true |
| visit            | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :visit

## call_comments

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| title            | string     | null: false                    |
| user             | references | null: false, foreign_key: true |
| call             | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :call