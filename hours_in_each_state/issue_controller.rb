require_relative 'lib/issue_manager'

manager = IssueManager.new
#puts manager.inspect
issues = manager.get_finished_issues_in_sprint(54,'2015-05-28')

issues.each do |issue|
  manager.set_changelog!(issue)
  puts issue.get_transitions
  
end