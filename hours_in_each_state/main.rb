require_relative 'scripts/issue_controller'
require 'date'

issue_constroller = IssueController.new()

issue_constroller.get_hours_in_sprint(54, DateTime.parse("2015-05-13"), DateTime.parse("2015-05-28"))