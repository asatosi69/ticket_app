# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## 必要な環境変数
- DATABASE_HOST
  - DBのhostを指定してください。
- DATABASE_DATABASE
  - 接続するdatabaseを指定してください。(create databaseでつくったdatabaseになります。)
- DATABASE_USERNAME
  - 接続に使うMySQLのユーザー名を指定してください。(ticket_appでよいかと思います。)
- DATABASE_PASSWORD
  - 接続に使うMySQLのユーザーのパスワードを指定してください。
- ACCESS_KEY_ID
  - SESの送信ができる権限をもったIAMのACCESS_KEY_IDを設定してください。
- SECRET_ACCESS_KEY
  - SESの送信ができる権限をもったIAMのSECRET_ACCESS_KEYを設定してください。
