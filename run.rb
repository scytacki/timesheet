require 'date'
require 'fileutils'

# figure out which month this for
date = Date.civil(2010, 7);
month = date.strftime("%b").downcase;

# set the output directory
root_dir = "/Users/scytacki/Documents/CCProjects/Timesheets/"
out_dir = root_dir + "#{month}-#{date.year}"
FileUtils.mkpath out_dir

def run_cmd(cmd)
  puts cmd
  system cmd
end

# copy the current chrome history file
chrome_history_db="#{out_dir}/ch-history.sqlite"
FileUtils.copy "#{ENV['HOME']}/Library/Application Support/Google/Chrome/Default/History", chrome_history_db

# run ical_from_chrome-history passing the appropriate options
chrome_history_ical="#{out_dir}/ch-history.ics"
#run_cmd "ruby ../ical-from-x/ical-from-chrome-history.rb -y #{date.year} -m #{date.mon} -d '#{chrome_history_db}' -o '#{chrome_history_ical}'"

# run ical-from-sent-email
sent_mail_ical="#{out_dir}/sent-mail.ics"
#run_cmd "ruby ../ical-from-x/ical-from-sent-email.rb -y #{date.year} -m #{date.mon} -o '#{sent_mail_ical}'"

# run ical-from-skype-calls
skype_calls_ical="#{out_dir}/skype-calls.ics"
run_cmd "ruby ../ical-from-x/skype/ical-from-skype-calls.rb -o '#{skype_calls_ical}'"


# this can be next month
# pull down the ical from my google calendar
