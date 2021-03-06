# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::ListDetails', type: :request do
  describe 'POST /create' do
    let(:list) { create(:list) }
    let(:book) { create(:cherry) }
    let(:list_detail) { { list_id: list.id, book_id: book.id } }
    let(:user) { list.user }

    context 'ログイン状態の場合' do
      context 'すでに登録済みの場合' do
        it '400が返ること' do
          sign_in user
          post api_list_details_path, params: { list_detail: }
          post api_list_details_path, params: { list_detail: }
          expect(response).to have_http_status(:bad_request)
        end

        it '登録がされないこと' do
          sign_in user
          post api_list_details_path, params: { list_detail: }
          post api_list_details_path, params: { list_detail: }
          expect { post api_list_details_path, params: { list_detail: } }.not_to change(ListDetail, :count)
        end

        it '「すでに登録済みです。」とエラーメッセージが出ること' do
          sign_in user
          post api_list_details_path, params: { list_detail: }
          post api_list_details_path, params: { list_detail: }
          expect(JSON.parse(response.body)['errorMessage']).to eq 'すでに登録済みです。'
        end
      end

      context '登録されていないリスト詳細の場合' do
        context '正常な値の場合' do
          it '201が返ること' do
            sign_in user
            post api_list_details_path, params: { list_detail: }
            expect(response).to have_http_status(:created)
          end

          it '登録が1件増えること' do
            sign_in user
            expect do
              post api_list_details_path, params: { list_detail: }
            end.to change(ListDetail, :count).by(1)
          end

          it '「リストに追加しました！」とメッセージが出ること' do
            sign_in user
            post api_list_details_path, params: { list_detail: }
            expect(JSON.parse(response.body)['message']).to eq 'リストに追加しました！'
          end
        end

        context '正常でない値がある場合' do
          it '422が返ること' do
            sign_in user
            list_detail['list_id'] = nil
            post api_list_details_path, params: { list_detail: }
            expect(response).to have_http_status(:unprocessable_entity)
          end

          it '登録がされないこと' do
            sign_in user
            list_detail['list_id'] = nil
            post api_list_details_path, params: { list_detail: }
            expect do
              post api_list_details_path, params: { list_detail: }
            end.not_to change(ListDetail, :count)
          end
        end
      end
    end

    context '未ログインの場合' do
      it '401が返ること' do
        post api_list_details_path, params: { list_detail: }
        expect(response).to have_http_status(:unauthorized)
      end

      it '登録がされないこと' do
        expect { post api_list_details_path, params: { list_detail: } }.not_to change(ListDetail, :count)
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:list_detail) { create(:list_detail_one) }
    let(:user) { list_detail.list.user }

    context 'ログイン状態の場合' do
      context '正常な値の場合' do
        it '200が返ること' do
          sign_in user
          delete api_list_detail_path(list_detail.id)
          expect(response).to have_http_status(:ok)
        end

        it 'リスト詳細が1件減ること' do
          sign_in user
          expect { delete api_list_detail_path(list_detail.id) }.to change(ListDetail, :count).by(-1)
        end

        it '「削除しました。」とメッセージが表示されること' do
          sign_in user
          delete api_list_detail_path(list_detail.id)
          expect(JSON.parse(response.body)['successMessage']).to eq '削除しました。'
        end
      end
    end

    context '未ログインの場合' do
      it '401が返ること' do
        delete api_list_detail_path(list_detail.id)
        expect(response).to have_http_status(:unauthorized)
      end

      it '削除がされないこと' do
        expect { delete api_list_detail_path(list_detail.id) }.not_to change(ListDetail, :count)
      end
    end
  end
end
