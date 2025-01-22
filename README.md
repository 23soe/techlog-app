## アプリの入手方法

```bash
git clone git@github.com:23soe/techlog-app.git
cd techlog-app
```

## インストール方法

### Ruby インストール（必要に応じ）

```bash
brew install rbenv ruby-build
rbenv install 3.1.6
rbenv global 3.1.6
rbenv rehash

```

### Bundler インストール（必要に応じ）

```bash
gem install bundler -v 2.6.3
```

### Gem のインストール

```
bundle config set path '.bundle'
bundle install
```

### データベースの作成

```
bin/rails db:create
bin/rails db:migrate
bin/rails db:migrate RAILS_ENV=test
```

## 起動方法

通常の Rails は `bin/rails s` で起動しますが、このアプリケーションは Tailwind CSS のコンパイルも行うため、`bin/dev` を使って起動します。

```
bin/dev
```

その後、ブラウザで http://localhost:3000/ にアクセスする。

## テスト実行方法

```
bin/rspec
```

## Rubocop による静的解析

```
bundle exec rubocop
```