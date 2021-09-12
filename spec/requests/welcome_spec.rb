# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Welcome', type: :request do
  describe 'GET /tos' do
    it 'success' do
      get tos_path
      expect(response).to have_http_status :ok
    end
  end

  describe 'GET /privacy_policy' do
    it 'success' do
      get privacy_policy_path
      expect(response).to have_http_status :ok
    end
  end
end
