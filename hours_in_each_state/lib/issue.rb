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
       if (history["items"][0]["field"] == "status")
         transition = [
           history["items"][0]["fromString"], 
           history["items"][0]["toString"], 
           history["created"]
         ]
         transitions << transition
       end
    end   
    transitions
  end
end