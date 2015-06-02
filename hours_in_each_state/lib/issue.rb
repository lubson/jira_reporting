class Issue
  attr_writer :body, :histories

  def initialize(body)
    @body = body
  end

  def get_key
    return @body["key"]
  end

  def get_summary
    @body["fields"]["summary"]
  end

  def get_type
    return @body["fields"]["issuetype"]["name"]
  end

  def ooc?
    return get_summary.include? "OOC"
  end
  
  def get_transitions
    transitions = []
    @histories.each do |history|
      position = get_status_position_in history
      if position >= 0
        transition = extract_status_from_history history, position
        transitions << transition
      end
    end   
    transitions
  end

private

  def get_status_position_in(history)
    position = -1
    history["items"].each_with_index do |item, index|
      position = index if item["field"] == "status"
    end
    position
  end

  def extract_status_from_history(history, position) 
    status = [
      history["items"][position]["fromString"], 
      history["items"][position]["toString"], 
      history["created"]
    ]
    return status
  end  
end
