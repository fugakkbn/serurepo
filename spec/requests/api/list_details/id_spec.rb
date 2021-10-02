# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::ListDetails::Id', type: :request do
  describe 'GET /index' do
    let(:list_detail) { create(:list_detail_one) }
    let(:list) { list_detail.list }
    let(:user) { list.user }
    let(:book) { list_detail.book }
    let(:other_book) { build(:fun_ruby) }

    context 'ログイン状態の場合' do
      context '登録済みの書籍の場合' do
        it '200が返ること' do
          sign_in user
          get api_list_details_id_index_path({ isbn: book.isbn_13 })
          expect(response).to have_http_status(:ok)
        end

        it 'リスト詳細IDが返ること' do
          sign_in user
          get api_list_details_id_index_path({ isbn: book.isbn_13 })
          expect(JSON.parse(response.body)['listDetailId']).to eq list_detail.id
        end
      end

      context '登録済みでない場合' do
        it '422が返ること' do
          sign_in user
          get api_list_details_id_index_path({ isbn: other_book.isbn_13 })
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'リスト詳細IDはnilであること' do
          sign_in user
          get api_list_details_id_index_path({ isbn: other_book.isbn_13 })
          expect(JSON.parse(response.body)['listDetailId']).to eq nil
        end
      end
    end

    context '未ログインの場合' do
      it '401が返ること' do
        get api_list_details_id_index_path({ isbn: book.isbn_13 })
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
