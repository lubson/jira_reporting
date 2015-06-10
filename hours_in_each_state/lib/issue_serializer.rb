require_relative 'issue'
require_relative 'status'

class IssueSerializer

def self.deserialize(json_issue)
    key         = json_issue["key"]
    summary     = json_issue["fields"]["summary"]
    type        = json_issue["fields"]["issuetype"]["name"]
    points      = 0 #TODO implement, it is in changelog Story Point
    description = json_issue["fields"]["description"]

    issue = Issue.new(
      key,
      summary,
      type,
      points,
      description
    )

    issue.labels = nil

    issue.statuses = deserialize_statuses json_issue["changelog"]["histories"]

    return issue
  end 

private
   def self.deserialize_statuses(histories)
    statuses = []
    histories.each do |history|
      position = get_status_position_in history
      if position >= 0
        status = extract_status_from_history history, position
        statuses.last.effective_till = status.created_at unless statuses.empty?
        statuses << status
      end
    end   
    statuses
  end

  def self.get_status_position_in(history)
    position = -1
    history["items"].each_with_index do |item, index|
      position = index if item["field"] == "status"
    end
    position
  end

  def self.extract_status_from_history(history, position) 
    status = Status.new(
      history["items"][position]["toString"], 
      DateTime.parse(history["created"])
    )
    return status
  end

end