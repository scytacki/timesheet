#!/usr/bin/env ruby
#
# timesheet.rb <month to display>
#
# Displays a list of the subject lines for all commits by an author
# in one month.  Defaults to the current month.  You can specify a
# different month in many different ways.
#
#   timesheet.rb last month
#   timesheet.rb 1           => last January
#   timesheet.rb jun         => June
#   timesheet.rb 1 year ago
#
# References:
#
# Chronic: A natural-language Time and Date parsing library:
#    http://chronic.rubyforge.org/
#
# Man page doc for: git log
#   http://www.kernel.org/pub/software/scm/git/docs/git-log.html
#
require 'rubygems'
require 'active_support/all'
require 'chronic'
devroot = '/Users/scytacki/Development/'
author = 'scytacki'
repositories = [
  ['XPP', 'rigse'],
  ['XPP', 'rails-ref-tree'],
  ['XPP', 'rigse-rails3'],
  ['XPP', 'rigse-1.9.3'],
  ['XPP', 'sensors-hobo'],
  ['ITSISU', 'rigse-itsisu'],
  ['ITSISU', 'video-paper-builder'],
  ['CLEAR', 'mysystem_sc'],
  ['CLEAR', 'wise4-vagrant'],
  ['CLEAR', 'MySystem-Wise-Integration-WIP'],
  ['SG', 'hobo'],
  ['SG', 'hobo-matrix'],
  ['SG', 'hobo-polymorphic-list'],
  ['SG', 'Smartgraphs'],
  ['SG', 'smartgraphs-authoring'],
  ['SG', 'smartgraphs-generator'],
  ['GG', 'genigames-lc']
]
if ARGV.empty?
  time = Time.now
else
  time = Chronic.parse(ARGV.join(' '), :context => :past)
end
date_format = '%m/%d/%Y'
month_start = time.at_beginning_of_month.strftime(date_format)
time_month_end   = time.at_end_of_month
if time_month_end > Time.now
  time_month_end = Time.now
end
month_end = time_month_end.strftime(date_format)
repositories.each do |project, dir|
  path = devroot + dir
  Dir.chdir(path) do
    commit_subjects = `git log HEAD --no-merges --reverse --since='#{month_start}' --pretty=format:"* %ad %s%n" --author=#{author}`
    commit_subjects.gsub!(/\n\n+\*/, "\n*")
    puts <<HEREDOC

project: #{project}
repository: #{path}
#{commit_subjects}
HEREDOC
  end
end
