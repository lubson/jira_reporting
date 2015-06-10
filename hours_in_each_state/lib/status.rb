require 'date'

class Status
  attr_accessor :name, :created_at, :effective_till

  def initialize(name, created_at)
    @name, @created_at = name, created_at 
    @effective_till = DateTime.now
  end

  def calculate_hours_spent_in_state(options = {})
    from = options[:from] || created_at
    to 	 = options[:to] || effective_till

    from = (created_at > from) ? created_at : from
    to	 = (effective_till < to) ? effective_till : to

    return ((to - from)*24 *60).to_i/60.0
  end 

  def ==(o)
    o.class == self.class && o.state == state
  end

protected
  def state
    [@name, @created_at]
  end
end