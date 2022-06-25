# frozen_string_literal: true

#
# 現在どのリストにも登録されていない本を
# 削除するための one_shot スクリプト
#
# リストから本を削除した時に、その本が他のリストに
# 登録されているかを確認して登録されていなければ削除する
# 機能を以下の PR で実装したので、実行は1度きりで OK
#   https://github.com/fugakkbn/serurepo/pull/227
#
# Usage:
#
#   $ RAILS_ENV=production bin/rails r scripts/one_shot/destroy_books_not_exists_in_list_details.rb

Rails.logger.info '*' * 30
Rails.logger.info "== Start scripts/one_shot/destroy_books_not_exists_in_list_details at #{Time.current}"
Rails.logger.info '*' * 30

Book.find_each do |book|
  if book.list_details.empty?
    Rails.logger.info "#{book.title} を削除します。"
    book.destroy!
  else
    Rails.logger.info "#{book.title} は削除しません。"
  end
end

Rails.logger.info '*' * 30
Rails.logger.info "== End scripts/one_shot/destroy_books_not_exists_in_list_details at #{Time.current}"
Rails.logger.info '*' * 30
