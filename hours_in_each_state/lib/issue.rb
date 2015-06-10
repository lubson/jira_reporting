require 'date'

class Issue
  attr_accessor :key, :summary, :type, :points, :description, :labels, :statuses

  def initialize(key, summary, type, points, description)
    @key, @summary, @type, @points, @description = key, summary, type, points, description
    @labels, @histories = [], []
  end

  def ooc?
    return summary.include? "OOC"
  end 

  def hours_in_status(status_index, from, to)
     status = statuses[status_index]
     next_status = statuses[status_index + 1]

  end
end