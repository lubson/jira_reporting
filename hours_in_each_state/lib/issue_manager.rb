require 'yaml'
require 'json'
require "open-uri"
require "open_uri_redirections"
require_relative 'issue'

class IssueManager
  attr_reader :url, :login, :pwd

  def initialize
    config = YAML.load_file("config.yaml")
    
    @url   = config["connection"]["url"]
    @login = config["connection"]["login"]
    @pwd   = config["connection"]["pwd"]
  end

  def get_issue(id)
    
  end
  
  def set_changelog!(issue)
    puts issue.inspect
    
    page = open(
      "#{@url}/rest/api/latest/issue/#{issue.get_key}?expand=changelog",
      :allow_redirections => :safe,
      http_basic_authentication: [@login,@pwd]
    )
    
    parsed = JSON.parse page.to_a[0]
  
    issue.histories = parsed["changelog"]["histories"]
  end

  # stories and bugs without ooc
  def get_finished_issues_in_sprint(sprint_id, accepted_before)
	  finished_issues = []
    
    page = open("#{@url}/rest/api/latest/search?jql=sprint%20%3D%20#{sprint_id}%20AND%20(issuetype%20%3D%20Story%20OR%20issuetype%20%3D%20Bug)%20AND%20status%20changed%20to%20(Accept)%20before%20#{accepted_before}%20%20ORDER%20BY%20key%20ASC",
	    :allow_redirections => :safe, 
	    http_basic_authentication: [@login,@pwd] 
    ) 

	  parsed = JSON.parse page.to_a[0]
	  
	  issues = parsed["issues"]
	  issues.each do |body|
      
      issue = Issue.new(body)
      
      if (issue.get_type == "Story" or issue.get_type == "Bug") and not issue.ooc?
	      finished_issues << issue
	    end
	  end
	end
end