# frozen_string_literal: true

class MailSender
  def self.sale_report(compared_data)
    compared_data.each do |data|
      next if data[:amazon].nil? && data[:dmm].nil? && data[:rakuten].nil?

      details = ListDetail.where(book_id: data[:book_id])
      details.each do |detail|
        user = detail.list.user
        sale_data = data
        SaleMailer.with(user: user, sale_data: sale_data).sale_email.deliver_now
      end
    end
  end
end
