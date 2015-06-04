require_relative '../lib/issue_manager'

class IssueController
attr_reader :issue_manager

  def initialize
    @issue_manager = IssueManager.new()
  end
  
  def get_hours_in_sprint(sprint_id, sprint_start, sprint_end)
    issues = issue_manager.get_all_issues_in_the_sprint(sprint_id)
    
    puts "Key, Date, From"
    
    issues.each do |issue|
      issue_manager.set_changelog!(issue)
      transitions = recalculate_transitions_dates_according_sprint!(issue, sprint_start, sprint_end)
      
      
      previous_transition = nil
      transitions.each do |transition|
        if previous_transition.nil? 
            hours = 0  
        else
            hours = ((transition[2] - previous_transition[2])*24 *60).to_i/60.0
        end
        puts "#{issue.get_key},#{hours},#{transition[0]}"
        previous_transition = transition
      end 
    end
  end
  
  def get_transitions_delivered_issues(sprint_id, date)
  #   issues = manager.get_finished_issues_in_sprint(54,'2015-05-28')
    
  #   puts "Key, Date, From, To"
    
  #   issues.each do |issue|
  #     manager.set_changelog!(issue)
  #     transitions = issue.get_transitions
  #     previous_transition = nil
  #     transitions.each do |transition|
  #       if previous_transition.nil? 
  #           hours = 0  
  #       else
  #           hours = ((DateTime.parse(transition[2].to_s) - DateTime.parse(previous_transition.to_s))*24 *60).to_i/60.0
  #       end
  #       puts "#{issue.get_key},#{hours},#{transition[0]},#{transition[1]}"
  #       previous_transition = transition
  #     end
  end
  
private

  def recalculate_transitions_dates_according_sprint!(issue, sprint_start, sprint_end)
    
    transitions = issue.get_transitions
  
    transitions.each do |transition|
      set_date_according_sprint!(transition, sprint_start, sprint_end)
    end
  end
  
  def set_date_according_sprint!(transition, sprint_start, sprint_end)
    if transition[2] < sprint_start
      transition[2] = sprint_start
    elsif transition[2] > sprint_end
      transition[2] = sprint_end
    end
  end
end