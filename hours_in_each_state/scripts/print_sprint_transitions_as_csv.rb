require_relative '../lib/issue_manager'

#add argument for sprint and date, store file normally and use it as input for non existing R sript :)
manager = IssueManager.new

issues = manager.get_finished_issues_in_sprint(54,'2015-05-28')

puts "Key, Date, From, To"

issues.each do |issue|
  manager.set_changelog!(issue)
  transitions = issue.get_transitions
  previous_transition = nil
  transitions.each do |transition|
    if previous_transition.nil? 
        hours = 0  
    else
        hours = ((DateTime.parse(transition[2].to_s) - DateTime.parse(previous_transition.to_s))*24 *60).to_i/60.0
    end
    puts "#{issue.get_key},#{hours},#{transition[0]},#{transition[1]}"
    previous_transition = transition
  end
end