# frozen_string_literal: true

require_relative '../comparer'
require_relative '../mail_sender'

namespace :sale_report do
  desc 'run crawler, comparer, and mail sender'
  task start: :environment do
    compared_data = Comparer::Books.run
    MailSender.sale_report(compared_data)
  end
end
