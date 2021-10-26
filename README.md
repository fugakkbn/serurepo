[![Lint](https://github.com/FUGA0618/serurepo/actions/workflows/lint.yml/badge.svg)](https://github.com/FUGA0618/serurepo/actions/workflows/lint.yml)
[![test](https://github.com/FUGA0618/serurepo/actions/workflows/test.yml/badge.svg)](https://github.com/FUGA0618/serurepo/actions/workflows/test.yml)

# About
「いつか買おうと思っている書籍」がセールになったときに通知するサービスです。<br>
サイト上で書籍を検索してリストに追加しておくと、リスト内の書籍がセールになったときに通知します。<br>
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
$ git clone https://github.com/FUGA0618/serurepo.git
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

# Log in

```
Email: test@example.com
PASS:  password
```
