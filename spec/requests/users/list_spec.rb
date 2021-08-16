# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::Lists', type: :request do
  describe 'GET /create' do
    it 'returns http success' do
      get '/users/list/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/users/list/show'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /update' do
    it 'returns http success' do
      get '/users/list/update'
      expect(response).to have_http_status(:success)
    end
  end
end
