require_relative '../lib/issue_manager'

#add argument for sprint and date, store file normally and use it as input for non existing R sript :)
manager = IssueManager.new

issues = manager.get_finished_issues_in_sprint(54,'2015-05-28')

puts "Key, Date, From, To"

issues.each do |issue|
  manager.set_changelog!(issue)
  transitions = issue.get_transitions
  transitions.each {|transition| puts "#{issue.get_key},#{transition[2]},#{transition[0]},#{transition[1]}"} 
end