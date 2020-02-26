# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, {
  :error => File.join(Whenever.path, "log", "error.log"),
  :standard => File.join(Whenever.path, "log", "cron.log")
}

every 1.week do
  runner "TopChallenge.new_week_challenge"
end

# Learn more: http://github.com/javan/whenever
