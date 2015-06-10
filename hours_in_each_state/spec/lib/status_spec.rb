require 'spec_helper'
require 'date'
require 'status'

describe "A Status" do
    
  it "calculates proper hours" do
    status = Status.new("Investigation Done", DateTime.parse("2015-03-19T08:22:46.262-0500"))
    
    status.effective_till = DateTime.parse("2015-03-19T11:52:46.262-0500")
    expect(status.calculate_hours_spent_in_state).to be == 3.5

    status.effective_till = DateTime.parse("2015-03-20T11:52:46.262-0500")
    expect(status.calculate_hours_spent_in_state).to be == 27.5

    expect(status.calculate_hours_spent_in_state from: DateTime.parse("2015-03-20T09:52:46.262-0500") ).to be == 2

    expect(status.calculate_hours_spent_in_state from: DateTime.parse("2015-03-20T09:52:46.262-0500"), to: DateTime.parse("2015-03-20T10:52:46.262-0500") ).to be == 1
  
    expect(status.calculate_hours_spent_in_state from: DateTime.parse("2015-02-20T09:52:46.262-0500"), to: DateTime.parse("2015-04-20T10:52:46.262-0500") ).to be == 27.5

    expect(status.calculate_hours_spent_in_state from: DateTime.parse("2015-01-20T09:52:46.262-0500"), to: DateTime.parse("2015-01-20T11:52:46.262-0500") ).to be == 0

    expect(status.calculate_hours_spent_in_state from: DateTime.parse("2015-05-20T09:52:46.262-0500"), to: DateTime.parse("2015-05-20T10:52:46.262-0500") ).to be == 0
  end  
end