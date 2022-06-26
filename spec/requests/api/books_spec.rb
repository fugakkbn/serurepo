# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Books', type: :request do
  describe 'POST /create' do
    let(:book) { attributes_for(:cherry) }
    let(:user) { create(:alice) }

    context 'ログイン状態の場合' do
      context 'すでに登録済みの書籍の場合' do
        it '200が返ること' do
          sign_in user
          post api_books_path, params: { book: }
          post api_books_path, params: { book: }
          expect(response).to have_http_status(:ok)
        end

        it '登録がされないこと' do
          sign_in user
          post api_books_path, params: { book: }
          post api_books_path, params: { book: }
          expect { post api_books_path, params: { book: } }.not_to change(Book, :count)
        end
      end

      context '登録されていない書籍の場合' do
        context '正常な値の場合' do
          it '201が返ること' do
            sign_in user
            post api_books_path, params: { book: }
            expect(response).to have_http_status(:created)
          end

          it '登録が1件増えること' do
            sign_in user
            expect { post api_books_path, params: { book: } }.to change(Book, :count).by(1)
          end
        end

        context '正常でない値がある場合' do
          it '422が返ること' do
            sign_in user
            book['title'] = nil
            post api_books_path, params: { book: }
            expect(response).to have_http_status(:unprocessable_entity)
          end

          it '登録がされないこと' do
            sign_in user
            book['title'] = nil
            expect { post api_books_path, params: { book: } }.not_to change(Book, :count)
          end

          it '「登録に失敗しました。」とエラーメッセージが出ること' do
            sign_in user
            book['title'] = nil
            post api_books_path, params: { book: }
            expect(JSON.parse(response.body)['errorMessage']).to eq '登録に失敗しました。'
          end
        end
      end
    end

    context '未ログインの場合' do
      it '401が返ること' do
        post api_books_path, params: { book: }
        expect(response).to have_http_status(:unauthorized)
      end

      it '登録がされないこと' do
        expect { post api_books_path, params: { book: } }.not_to change(Book, :count)
      end
    end
  end
end
