# frozen_string_literal: true

class MailSender
  def self.sale_report(compared_data)
    compared_data.each do |data|
      next if all_data_nil?(data)

      book = Book.find(data[:book_id])
      book.lists.each do |list|
        user = list.user
        discount_rating = get_rating(user)
        discounted_price = (book.price * discount_rating).truncate

        data[:amazon] = nil if higher_than_discounted_price?(data[:amazon], discounted_price)
        data[:dmm] = nil if higher_than_discounted_price?(data[:dmm], discounted_price)
        data[:rakuten] = nil if higher_than_discounted_price?(data[:rakuten], discounted_price)
        next if all_data_nil?(data)

        SaleMailer.with(user: user, sale_data: data).sale_email.deliver_now
      end
    end
  end

  def self.all_data_nil?(data)
    if data[:amazon].nil? && data[:dmm].nil? && data[:rakuten].nil?
      true
    else
      false
    end
  end

  def self.get_rating(user)
    case user.discount_rating.to_a
    when [:even]
      1
    when [:over10]
      0.9
    when [:over20]
      0.8
    when [:over30]
      0.7
    when [:over50]
      0.5
    else
      1
    end
  end

  def self.higher_than_discounted_price?(price_data, discounted_price)
    if price_data.present? && (price_data[:price] >= discounted_price)
      true
    else
      false
    end
  end
end
