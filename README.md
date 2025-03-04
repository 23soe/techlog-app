# Blog
URL : [https://techlog-app-ihjf.onrender.com](https://techlog-app-ihjf.onrender.com) (X)

# プロジェクトのセットアップ手順
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
bin/rails db:create
bin/rails db:migrate
bin/rails db:migrate RAILS_ENV=test
```
## 起動方法
```
bin/rails s
```

## テスト実行方法

```
bundle exec rspec
```

## Rubocop による静的解析

```
bundle exec rubocop
```

# 機能の説明

- ブログ記事の管理(CRUD) 
- 検索・フィルタリング機能(カテゴリやタグ)
- ユーザー認証機能(Railsでログイン/ログアウト)
- レスポンシブデザイン(tailwindcss)

