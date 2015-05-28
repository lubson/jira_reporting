require "open-uri"
require "open_uri_redirections"
require "json"


def is_status?(history)
  return history["items"][0]["field"] == "status"
end

def extract_status(history)
  arr = []
  arr << history["items"][0]["fromString"]
  arr << history["items"][0]["toString"]
  arr << history["created"]
end

def is_issue?(issue, issue_type)
  return issue["fields"]["issuetype"]["name"] == issue_type
end

def is_ooc?(issue)
  return issue["fields"]["summary"].include? "OOC"
end

#does not return OOC
def all_sprint_issues

  uri = "https://medfusion.atlassian.net/rest/api/latest/search?jql=sprint%20%3D%2054%20AND%20(issuetype%20%3D%20Story%20OR%20issuetype%20%3D%20Bug)%20AND%20status%20changed%20to%20(Accept)%20before%202015-05-28%20%20ORDER%20BY%20key%20ASC"
  issuesIds = [] 
  page = open( uri,
        :allow_redirections => :safe, 
        http_basic_authentication: ["", ""] 
  ) 
  parsed = JSON.parse page.to_a[0]
  
  issues = parsed["issues"]
  issues.each do |issue|
    if ((is_issue?(issue,"Story") or is_issue?(issue,"Bug")) and not is_ooc?(issue))
      issuesIds << issue["key"]
    end
  end
  issuesIds
end


statuses_for_whole_sprint = []

issuesIds = all_sprint_issues

issuesIds.each do |issueId|
  
  
  
  uri = "https://medfusion.atlassian.net/rest/api/latest/issue/#{issueId}?expand=changelog"
  
  page = open( uri,
        :allow_redirections => :safe, 
        http_basic_authentication: ["", ""] 
  ) 
  
  parsed = JSON.parse page.to_a[0]
  
  histories = parsed["changelog"]["histories"]
  
  histories.each do |history| 
    if is_status?(history)
      statuses_for_whole_sprint << extract_status(history)

    end
  end
end

puts statuses_for_whole_sprint.inspect



