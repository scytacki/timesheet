#!/usr/bin/env ruby

require 'date'
require 'fileutils'

# figure out which month this for
$date = Date.civil(2012, 5);
$month = $date.strftime("%b").downcase;

# set the output directory
root_dir = "/Users/scytacki/Documents/CCProjects/Timesheets/"
$out_dir = root_dir + "#{$month}-#{$date.year}"
FileUtils.mkpath $out_dir

def run_cmd(cmd)
  cmd = "ruby ../ical-from-x/" + cmd
  puts cmd
  system cmd
end

def run_metric(metric_name)
  run_cmd "ical-from-#{metric_name}.rb -y #{$date.year} -m #{$date.mon} -o '#{$out_dir}/#{metric_name}.ics'"
end


run_metric 'system-sleep'
run_metric 'chrome-history'
run_metric 'skype-calls'
run_metric 'sent-email'

# the google calendar is setup to sync in iCal if I just refresh it so I don't need to write a script for that

# print out directions for what to do next
puts "Now clear the existing calendars from ical"
puts "Then run this command"
puts "  open #{$out_dir}/*.ics"
