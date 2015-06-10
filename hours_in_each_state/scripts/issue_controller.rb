require_relative '../lib/issue_manager'


class IssueController
attr_reader :issue_manager

  def initialize
    @issue_manager =  IssueManager.new()
  end
  
  def get_hours_in_sprint(sprint_id, sprint_start, sprint_end)
    result = []

    issues = issue_manager.get_sprint_issues sprint_id
    
    issues.each do |issue|
      issue.statuses.each do |status| 
        result << [
          sprint_id,
          issue.key,
          status.name,
          status.calculate_hours_spent_in_state(from: sprint_start, to: sprint_end)
        ]
      end
    end
    return result
  end  
end