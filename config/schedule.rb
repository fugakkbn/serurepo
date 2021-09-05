require File.expand_path(File.dirname(__FILE__) + "/environment")
set :environment, :development
set :output, "#{Rails.root}/log/cron.log"

every 1.day, at: '5:30 am' do
  rake 'sale_report:start'
end
