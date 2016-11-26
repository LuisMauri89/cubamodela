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

every 5.minutes do
	rake "casting_tasks:working_test"
	Rails.logger.info("Task test running at #{Time.now}")
end

every 5.minutes do
	rake "casting_tasks:alert_casting_proximity"
	Rails.logger.info("Task proximity running at #{Time.now}")
end

every 5.minutes do
	rake "casting_tasks:change_casting_expired_status"
	Rails.logger.info("Task status running at #{Time.now}")
end

