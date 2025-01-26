## アプリの入手方法

```bash
git clone git@github.com:23soe/techlog-app.git
cd techlog-app
```

## インストール方法

## Ruby インストール（必要に応じ）
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
bundle install
```

### データベースの作成

```
bin/rails db:schema:load
```

## テスト実行方法

```
bundle exec rspec
```

## Rubocop による静的解析

```
bundle exec rubocop
```

## Category データベースの作成
```
Category.create(name: 'テストカテゴリ1')
Category.create(name: 'テストカテゴリ2')
Category.create(name: 'テストカテゴリ3'

```