# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'books', type: :system do # rubocop: disable Metrics/BlockLength
  before do
    alice = create(:alice)
    login(alice)
  end

  describe 'ISBNで検索した場合' do
    it 'プロを目指す人のためのRuby入門が表示される' do
      visit root_path
      fill_in 'Query', with: '9784774193977'
      click_button '検索する'
      expect(page).to have_selector '#book-title', text: 'プロを目指す人のためのRuby入門'
    end
  end

  describe 'ワード検索した場合' do
    it '.mediaが2つ以上ある' do
      visit root_path
      fill_in 'Query', with: 'ruby'
      click_button '検索する'
      media = all('.block .media')
      expect(media.size).to be >= 2
    end
  end

  describe '検索結果がなかった場合' do
    it '該当する書籍がありませんでしたと表示される' do
      visit root_path
      fill_in 'Query', with: '123456789'
      click_button '検索する'
      expect(page).to have_content '該当する書籍がありませんでした。'
    end
  end
end
