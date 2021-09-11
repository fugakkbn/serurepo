# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GoogleOauth', type: :request do
  include GoogleOauthMockHelper

  describe 'Google認証' do
    before do
      OmniAuth.config.mock_auth[:google_oauth2] = nil
      Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
      Rails.application.env_config['omniauth.auth'] = google_oauth_mock
    end

    it '成功すること' do
      post '/users/auth/google_oauth2/callback'
      expect(response).to have_http_status :found
    end
  end
end
