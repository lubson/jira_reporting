class Issue
  attr_reader :id, :parsed

  def initialize(id, parsed)
  	@id     = id
    @parsed = parsed
  end

  def load
    uri  = "https://medfusion.atlassian.net/rest/api/latest/search?jql=sprint%20%3D%2054%20AND%20(issuetype%20%3D%20Story%20OR%20issuetype%20%3D%20Bug)%20AND%20status%20changed%20to%20(Accept)%20before%20#{2015-05-28}%20%20ORDER%20BY%20key%20ASC" 
    page = open( uri,
        :allow_redirections => :safe, 
        http_basic_authentication: ["lhruban", "damnedlicenses"] 
    ) 
    parsed = JSON.parse page.to_a[0]
  end

  def load_history
  end

  def get_transitions
  end

  def is_issue?(issue, issue_type)
    return issue["fields"]["issuetype"]["name"] == issue_type
  end

  def is_ooc?(issue)
    return issue["fields"]["summary"].include? "OOC"
  end
end