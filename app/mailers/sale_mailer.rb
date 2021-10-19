# frozen_string_literal: true

class SaleMailer < ApplicationMailer
  helper :books

  default from: 'せるれぽ <noreply@serurepo.com>'

  def sale_email
    @user = params[:user]
    @sale_data = params[:sale_data]
    @book = Book.find(@sale_data[:book_id])
    mail(to: @user.email, subject: "【せるれぽ】#{@book.title}がセールになっています")
  end
end
