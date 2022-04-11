# README

## 初期化 for Mac
### インストール
- `bundle install`がうまくいかない場合は[ここ](https://phasetr.com/archive/pg/ruby/#macmysql2)などを参照.
- `rbenv`をインストールして`ruby 3.0.0`を導入: [ここ](https://phasetr.com/archive/pg/ruby/#rbenv)などを参照.

```sh
bundle install
mysql -uroot

GRANT ALL PRIVILEGES ON *.* TO 'dbuser'@'localhost' IDENTIFIED BY 'dbpass' WITH GRANT OPTION;
quit

rails db:migrate

mysqladmin variables | grep socket # socketの場所を確認

| performance_schema_max_socket_classes   |              10 |
| performance_schema_max_socket_instances |              -1 |
| socket                                  | /tmp/mysql.sock |
```

- ファイルを書き換え: コミットしないこと! (できればMac用のファイルを作りたいが...)

```config/database.yml
#変更前
socket: /var/run/mysqld/mysqld.sock
#変更後
socket: /tmp/mysql.sock
```

- 次のコマンドを実行

```sh
rails db:create
rails db:migrate

brew install yarn
yarn install
```

### 起動・終了
```sh
mysql.server start
pgrep mysql
rails s

mysql.server stop
pgrep mysql
```

## Ruby用設定
- コンソールの注意を見て設定する

```sh
gem install sorbet
```

## MEMO heroku release
- [参考](https://devcenter.heroku.com/ja/articles/getting-started-with-rails6)

```sh
# heroku createなどは対応済み
git push heroku master
heroku run rake db:migrate
heroku open
```

## ORIG

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
