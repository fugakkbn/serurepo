# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ListDetails', type: :system do
  describe '#destroy' do
    context '削除ボタンをクリックした場合' do
      before do
        list_detail = create(:list_detail_one)
        login(list_detail.list.user)
        visit users_list_path list_detail.list.id
        page.accept_confirm do
          click_link '削除する'
        end
      end

      it '削除しましたと表示される' do
        expect(page).to have_selector '.notification.is-success.is-light', text: '削除しました。'
      end

      it '削除した書籍が一覧からなくなっている' do
        expect(page).not_to have_content 'プロを目指す人のためのRuby入門'
      end
    end
  end
end
