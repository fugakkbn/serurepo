[![Deploy with Capistrano](https://github.com/fugakkbn/serurepo/actions/workflows/deploy_with_capistrano.yml/badge.svg)](https://github.com/fugakkbn/serurepo/actions/workflows/deploy_with_capistrano.yml)
[![Lint](https://github.com/fugakkbn/serurepo/actions/workflows/lint.yml/badge.svg)](https://github.com/fugakkbn/serurepo/actions/workflows/lint.yml)
[![test](https://github.com/fugakkbn/serurepo/actions/workflows/test.yml/badge.svg)](https://github.com/fugakkbn/serurepo/actions/workflows/test.yml)
[![codecov](https://codecov.io/gh/FUGA0618/serurepo/branch/main/graph/badge.svg?token=XPH2NIQQGP)](https://codecov.io/gh/FUGA0618/serurepo)

![ロゴ_横長](https://user-images.githubusercontent.com/58870882/139534536-65598064-7be0-4a2b-975a-3a722f1a8f8a.png)

# About
「いつか買おうと思っている書籍」がセールになったときに通知するサービスです。<br>
サイト上で書籍を検索して「通知を受け取る」を押しておくと、その書籍がセールになったときに通知します。<br>
書籍は何冊でも追加できます。<br>
もう、いろんなサイトでセールをやっていないか確認する必要はないし、書籍のセールを見逃すことはありません。

# URL

```
https://serurepo.com
```

# Features
- サイト上で書籍名または13桁のISBNから、書籍を検索できます。
- 検索結果から「セール通知を受け取る」をクリックすると、その書籍がセールになった時にメールで通知されます。
- セールとみなす割引率は、設定ページで設定できます。

# Composition Diagram
![せるれぽ](https://user-images.githubusercontent.com/58870882/138904938-f4698b13-3405-4c8d-b333-054b9eaef9b6.png)

# Setup

```bash
$ git clone https://github.com/fugakkbn/serurepo.git
```

```bash
$ cd serurepo
```

```bash
$ bin/setup
```

```bash
$ bin/rails s
```

# Seeds

```bash
$ bin/rails db:seed
```

# Lint & Tests

```shell
$ ./bin/lint
$ bundle exec rspec
```

# Log in

```
Email: test@example.com
PASS:  password
```
