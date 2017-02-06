# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

require File.expand_path(File.dirname(__FILE__) + "/environment")

every :day, at: '12:40 am' do
	Rails.logger.info "#{Time.current} - PERFORMING_TASK: casting_expiration_proximity_task"
	rake "casting_tasks:casting_expiration_proximity_task"
end

every :day, at: '12:10 am' do
	Rails.logger.info "#{Time.current} - PERFORMING_TASK: casting_expired_task"
	rake "casting_tasks:casting_expired_task"
end

every :day, at: '1:30 am' do
	Rails.logger.info "#{Time.current} - PERFORMING_TASK: casting_reviews_dont_show_again_task"
	rake "casting_tasks:casting_reviews_dont_show_again_task"
end

every :day, :at => '1:00 am' do
  	Rails.logger.info "#{Time.current} - PERFORMING_TASK: sitemap:refresh"
  	rake "-s sitemap:refresh"
end

