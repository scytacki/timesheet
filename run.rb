#!/usr/bin/env ruby

require 'date'
require 'fileutils'

# figure out which month this for
date = Date.civil(2012, 4);
month = date.strftime("%b").downcase;

# set the output directory
root_dir = "/Users/scytacki/Documents/CCProjects/Timesheets/"
out_dir = root_dir + "#{month}-#{date.year}"
FileUtils.mkpath out_dir

def run_cmd(cmd)
  cmd = "ruby ../ical-from-x/" + cmd
  puts cmd
  system cmd
end

# run ical-from-system-events
system_sleep_ical="#{out_dir}/system_sleep.ics"
run_cmd "ical-from-system.rb -y #{date.year} -m #{date.mon} -o '#{system_sleep_ical}'"

# copy the current chrome history file
chrome_history_db="#{out_dir}/ch-history.sqlite"
FileUtils.copy "#{ENV['HOME']}/Library/Application Support/Google/Chrome/Default/History", chrome_history_db
# run ical_from_chrome-history passing the appropriate options
chrome_history_ical="#{out_dir}/ch-history.ics"
run_cmd "ical-from-chrome-history.rb -y #{date.year} -m #{date.mon} -d '#{chrome_history_db}' -o '#{chrome_history_ical}'"

# run ical-from-skype-calls
skype_calls_ical="#{out_dir}/skype-calls.ics"
run_cmd "skype/ical-from-skype-calls.rb -o '#{skype_calls_ical}'"

# run ical-from-sent-email
sent_mail_ical="#{out_dir}/sent-mail.ics"
run_cmd "ical-from-sent-email.rb -y #{date.year} -m #{date.mon} -o '#{sent_mail_ical}'"

# the google calendar is setup to sync in iCal if I just refresh it so I don't need to write a script for that
