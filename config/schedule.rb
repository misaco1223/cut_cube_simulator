# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
require File.expand_path(File.dirname(__FILE__) + "/environment")
rails_env = ENV["RAILS_ENV"] || :development
set :environment, rails_env
set :output, "#{Rails.root}/log/cron.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end

every 1.day, at: "00:00 am" do
  rake "cleanup:delete_expired_guest_data"
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
