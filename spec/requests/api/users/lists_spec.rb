# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Users::Lists', type: :request do
  describe 'GET /show' do
    let(:list_detail) { create(:list_detail_one) }
    let(:list) { list_detail.list }
    let(:user) { list.user }

    context 'ログイン状態の場合' do
      before do
        sign_in user
        get api_users_list_path(list)
      end

      it '200が返ること' do
        expect(response).to have_http_status(:ok)
      end

      it 'json形式でリスト登録済みの書籍が返ること' do
        json = JSON.parse(response.body)
        expect(json.length).to eq 1
      end

      it 'list_detail_idが同値であること' do
        json = JSON.parse(response.body)
        expect(json['books'][0]['list_detail_id']).to eq list_detail.id
      end

      it '書籍のIDが格納されていること' do
        json = JSON.parse(response.body)
        expect(json['books'][0]['book']['id']).to eq list_detail.book.id
      end
    end

    context 'ログイン状態でない場合' do
      it '401が返ること' do
        get api_users_list_path(list)
        expect(response).to have_http_status('401')
      end
    end
  end

  describe 'POST /create' do
    context 'ログイン状態の場合' do
      context 'すでに登録済みの場合' do
        let(:list) { create(:list) }
        let(:user) { list.user }

        it '200が返ること' do
          sign_in user
          post api_users_lists_path
          expect(response).to have_http_status(:ok)
        end

        it '登録がされないこと' do
          sign_in user
          post api_users_lists_path
          expect { post api_users_lists_path }.not_to change(List, :count)
        end

        it 'リストIDが返ること' do
          sign_in user
          post api_users_lists_path
          expect(JSON.parse(response.body)['listId']).to eq user.list.id
        end
      end

      context '登録済みでない場合' do
        let(:user) { create(:alice) }

        it '201が返ること' do
          sign_in user
          post api_users_lists_path
          expect(response).to have_http_status(:created)
        end

        it '登録が1件増えること' do
          sign_in user
          expect { post api_users_lists_path }.to change(List, :count).by(1)
        end

        it 'リストIDが数値で返ること' do
          sign_in user
          post api_users_lists_path
          expect(JSON.parse(response.body)['listId']).to be_integer
        end
      end
    end

    context '未ログインの場合' do
      it '401が返ること' do
        post api_users_lists_path
        expect(response).to have_http_status(:unauthorized)
      end

      it '登録がされないこと' do
        expect { post api_users_lists_path }.not_to change(List, :count)
      end
    end
  end
end
