# frozen_string_literal: true

FactoryBot.define do
  factory :cherry, class: 'Book' do
    title { 'プロを目指す人のためのRuby入門' }
    author { '伊藤淳一（プログラミング）' }
    image { 'https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/3977/9784774193977.jpg?_ex=120x120' }
    url { 'https://hb.afl.rakuten.co.jp/hgc/g00q0727.m0lf90b6.g00q0727.m0lfa419/?pc=https%3A%2F%2Fbooks.rakuten.co.jp%2Frb%2F15209044%2F' }
    sales_date { '2017年12月' }
    isbn13 { '9784774193977' }
    price { 3278 }
  end

  factory :fun_ruby, class: 'Book' do
    title { 'たのしいRuby 第6版' }
    author { '高橋 征義/後藤 裕蔵' }
    image { 'https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/9844/9784797399844.jpg?_ex=120x120' }
    url { 'https://hb.afl.rakuten.co.jp/hgc/g00q0727.m0lf90b6.g00q0727.m0lfa419/?pc=https%3A%2F%2Fbooks.rakuten.co.jp%2Frb%2F15822269%2F' }
    sales_date { '2019年03月20日頃' }
    isbn13 { '9784797399844' }
    price { 2860 }
  end

  factory :perfect_rails, class: 'Book' do
    title { 'パーフェクト Ruby on Rails　【増補改訂版】' }
    author { 'すがわらまさのり／前島真一/橋立友宏／五十嵐邦明' }
    image { 'https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/4626/9784297114626.jpg?_ex=120x120' }
    url { 'https://hb.afl.rakuten.co.jp/hgc/g00q0727.m0lf90b6.g00q0727.m0lfa419/?pc=https%3A%2F%2Fbooks.rakuten.co.jp%2Frb%2F16352336%2F' }
    sales_date { '2020年07月25日頃' }
    isbn13 { '9784297114626' }
    price { 3828 }
  end

  factory :cho_nyumon, class: 'Book' do
    title { 'ゼロからわかるRuby超入門' }
    author { '五十嵐邦明/松岡浩平' }
    image { 'https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/1237/9784297101237.jpg?_ex=120x120' }
    url { 'https://hb.afl.rakuten.co.jp/hgc/g00q0727.m0lf90b6.g00q0727.m0lfa419/?pc=https%3A%2F%2Fbooks.rakuten.co.jp%2Frb%2F15664673%2F' }
    sales_date { '2018年12月' }
    isbn13 { '9784297101237' }
    price { 2728 }
  end

  factory :genba_rails, class: 'Book' do
    title { '現場で使える Ruby on Rails 5速習実践ガイド' }
    author { '大場寧子/松本拓也' }
    image { 'https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/2227/9784839962227.jpg?_ex=120x120' }
    url { 'https://hb.afl.rakuten.co.jp/hgc/g00q0727.m0lf90b6.g00q0727.m0lfa419/?pc=https%3A%2F%2Fbooks.rakuten.co.jp%2Frb%2F15628625%2F' }
    sales_date { '2018年10月19日頃' }
    isbn13 { '9784839962227' }
    price { 3828 }
  end

  factory :dokugaku, class: 'Book' do
    title { '独学大全' }
    author { '読書猿' }
    image { 'https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/8536/9784478108536.jpg?_ex=120x120' }
    url { 'https://hb.afl.rakuten.co.jp/hgc/g00q0727.m0lf90b6.g00q0727.m0lfa419/?pc=https%3A%2F%2Fbooks.rakuten.co.jp%2Frb%2F15628625%2F' }
    sales_date { '2018年10月19日頃' }
    isbn13 { '9784478108536' }
    price { 3080 }
  end

  factory :dokusyu_js, class: 'Book' do
    title { '独習JavaScript 新版' }
    author { 'CodeMafia 外村将大' }
    image { 'https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/8536/9784478108536.jpg?_ex=120x120' }
    url { 'https://hb.afl.rakuten.co.jp/hgc/g00q0727.m0lf90b6.g00q0727.m0lfa419/?pc=https%3A%2F%2Fbooks.rakuten.co.jp%2Frb%2F15628625%2F' }
    sales_date { '2021年11月15日' }
    isbn13 { '9784798160276' }
    price { 3278 }
  end

  factory :kumikomi_os, class: 'Book' do
    title { 'リアルタイム組込みOS基礎講座' }
    author { 'Carolone Yao' }
    image { 'https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/8536/9784478108536.jpg?_ex=120x120' }
    url { 'https://hb.afl.rakuten.co.jp/hgc/g00q0727.m0lf90b6.g00q0727.m0lfa419/?pc=https%3A%2F%2Fbooks.rakuten.co.jp%2Frb%2F15628625%2F' }
    sales_date { '2005年11月02日' }
    isbn13 { '4798110043' }
    price { 3740 }
  end
end
