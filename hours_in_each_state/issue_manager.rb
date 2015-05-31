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

  # list of stories and bugs without ooc
  def get_finished_issues_in_sprint(sprint_id, accepted_before)
	  issuesIds = []
    
    uri = "#{url}/rest/api/latest/search?jql=sprint%20%3D%20#{sprint_id}%20AND%20(issuetype%20%3D%20Story%20OR%20issuetype%20%3D%20Bug)%20AND%20status%20changed%20to%20(Accept)%20before%20#{accepted_before}%20%20ORDER%20BY%20key%20ASC"
    
    page = open(@uri,
	           :allow_redirections => :safe, 
	           http_basic_authentication: [@login,@pwd] 
           ) 

	  parsed = JSON.parse page.to_a[0]
	  
	  issues = parsed["issues"]
	  issues.each do |item|
	    item

      if ((is_issue?(issue,"Story" or is_issue?(issue,"Bug")) and not is_ooc?(issue))
	      issuesIds << issue["key"]
	    end
	  end
	  issuesIds
	  end 

end