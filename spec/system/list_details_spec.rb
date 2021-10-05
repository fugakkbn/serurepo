# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ListDetails', type: :system do
  describe '#destroy' do
    context '削除ボタンをクリックした場合' do
      before do
        list_detail = create(:list_detail_one)
        login(list_detail.list.user)
        visit users_list_path list_detail.list.id
      end

      it '削除の確認ダイアログが表示される' do
        find('.button.is-danger', text: '削除する').click
        expect(page.accept_confirm).to eq '削除してよろしいですか？'
      end

      it '削除しましたと表示される' do
        page.accept_confirm do
          find('.button.is-danger', text: '削除する').click
        end
        expect(page.accept_confirm).to eq '削除しました。'
      end

      it '削除した書籍が一覧からなくなっている' do
        page.accept_confirm do
          find('.button.is-danger', text: '削除する').click
          page.accept_confirm
        end
        expect(page).not_to have_content 'プロを目指す人のためのRuby入門'
      end
    end
  end
end
