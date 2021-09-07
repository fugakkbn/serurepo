# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SaleMailer, type: :mailer do
  describe 'sale_email' do
    let(:list) { create(:list) }
    let(:user) { list.user }
    let(:book) { create(:cherry) }
    let(:sale_data) do
      { book_id: book.id,
        amazon:
          { price: 2926,
            url: 'https://www.amazon.co.jp/dp/B0734GH91L/' } }
    end
    let(:mail) { described_class.with(user: user, sale_data: sale_data).sale_email }

    it 'ユーザーのメールアドレスに送ること' do
      expect(mail.to).to eq [user.email]
    end

    it '指定のメールアドレスから送信すること' do
      expect(mail.from).to eq ['aax.chiri@gmail.com']
    end

    it '正しい件名で送信すること' do
      expect(mail.subject).to eq "【せるれぽ】#{book.title}がセールになっています"
    end
  end
end
