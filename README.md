![logo_blue](https://user-images.githubusercontent.com/80817032/117933677-c8034800-b33c-11eb-8432-2f9f9cc57a47.png)

# サービスマンの訪問履歴管理アプリ

- 顧客ごとの訪問履歴・見積履歴を残す事ができます。
- 団体ごとの管理者IDを作成し、管理者がユーザーを作成する事で団体ごとの情報共有が可能です。
- 顧客の現在の状況を記載する事で、終了した案件かどうかを判断できます。

# URL
- https://footprints-35193.herokuapp.com/

# テスト用アカウント
- 管理者アカウント

    Email：kyoto@hu

    password：kyo123
- ユーザー

    Email：kiyomizu@temple

    password：kiyo123

# 利用方法
## 管理者アカウント
- 管理者アカウントでログインする事で、管理者の組織のユーザーを作成する事ができます。
- 管理者はユーザーの管理のみを行います。
## ユーザーアカウント
- 管理者の作成したユーザーでログインする事で、顧客情報の登録・詳細閲覧ができます。
- 顧客情報を登録し、顧客訪問時の情報・見積り依頼時の情報を入力する事で履歴を残します。
- 訪問情報。見積り情報にステータスを設定する事で、今後の訪問や見積り提出の必要があるのかを判断する事ができます。
- 訪問情報・見積り情報にコメントを追加する事で情報共有をより正確に行う事ができます。

# 目指した課題解決

前職サービスエンジニアとして働いており、機械の故障に対する突発的な訪問依頼が多い為いつ誰がどの現場に行くのか、行っていたのかの情報共有が曖昧になっていました。
誰かが修理した後で再び故障し、別の者が同じ処置を再び行なった為また同様の症状で故障するという事例が少なくなく問題に感じておりました。
顧客ごとに以前の処置内容を履歴として残す事で再発防止や事前準備の手助けになればと考え本アプリケーションを作成しました。

# DEMO
- トップページでは、管理者の登録・ログイン、ユーザーのログインを選択します。
<img width="1182" alt="スクリーンショット 2021-05-12 18 06 51" src="https://user-images.githubusercontent.com/80817032/117949364-043ea480-b34d-11eb-8032-ed7f7c2760bc.png">

- 管理者は、ユーザー情報の追加・編集・削除が可能です。
<img width="1063" alt="スクリーンショット 2021-05-13 10 13 21" src="https://user-images.githubusercontent.com/80817032/118063400-fb44e600-b3d3-11eb-8b39-4462807285c3.png">

- ユーザーは顧客情報の追加と閲覧、削除が可能です。顧客の情報は管理者が同一のユーザー同士で共有されます。
<img width="1060" alt="スクリーンショット 2021-05-13 10 35 41" src="https://user-images.githubusercontent.com/80817032/118064968-0d745380-b3d7-11eb-9885-d33d3bac4e63.png">

- 顧客の詳細画面では、訪問情報、見積り情報の作成・編集・閲覧・削除が可能です。訪問情報と見積り情報はタブによって切り替えることができます。
<img width="971" alt="スクリーンショット 2021-05-13 11 32 30" src="https://user-images.githubusercontent.com/80817032/118069361-02252600-b3df-11eb-9bcc-3ed3800da268.png">

- 訪問・見積り情報の詳細画面では、情報の編集・削除、コメントの記入ができます。
<img width="972" alt="スクリーンショット 2021-05-13 11 36 40" src="https://user-images.githubusercontent.com/80817032/118069700-94c5c500-b3df-11eb-90da-08bd6b822e5e.png">


# データベース
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
| address          | string     | null: false                    |
| charge           | string     |                                |
| charge_tel       | string     |                                |
| admin            | references | null: false, foreign_key: true |

### Association

- belongs_to :admin
- has_one    :visits
- has_one    :calls

## visits

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| title            | string     | null: false                    |
| date             | datetime   | null: false                    |
| content          | string     | null: false                    |
| status_id        | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |
| client           | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :client

## calls

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| title            | string     | null: false                    |
| date             | datetime   | null: false                    |
| content          | string     | null: false                    |
| status_id        | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |
| client           | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :client

## visit_comments

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| comment          | string     | null: false                    |
| user             | references | null: false, foreign_key: true |
| visit            | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :visit

## call_comments

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| comment          | string     | null: false                    |
| user             | references | null: false, foreign_key: true |
| call             | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :call