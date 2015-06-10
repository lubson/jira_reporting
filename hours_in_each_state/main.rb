require_relative 'scripts/issue_controller'
require 'date'

issue_constroller = IssueController.new()

sprints =[
  [25, DateTime.parse("2015-03-25"), DateTime.parse("2015-04-08")],
  [31, DateTime.parse("2015-04-08"), DateTime.parse("2015-04-23")],
  [37, DateTime.parse("2015-04-23"), DateTime.parse("2015-05-07")],	
  [54, DateTime.parse("2015-05-13"), DateTime.parse("2015-05-27")],
  [64, DateTime.parse("2015-05-27"), DateTime.parse("2015-06-10")]
]

data = []

sprints.each do |sprint|
  data = data + issue_constroller.get_hours_in_sprint(sprint[0], sprint[1], sprint[2])  
end

puts "Sprint ID, Issue, Status, Hours"
data.each do |row|
 puts "#{row[0]}, #{row[1]}, #{row[2]}, #{row[3].round(2)},"
end