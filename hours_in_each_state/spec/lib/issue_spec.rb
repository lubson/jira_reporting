require 'issue'
require 'json'
require 'spec_helper'
require 'date'

describe "An Issue" do
  
  son_75 = Issue.new(
    JSON.parse(
      '{
        "key":"SON-75", 
        "fields":{
          "issuetype":{
            "name":"Story"
          },
          "summary":"Setup JBOSS 7"
        }
      }'
    )
  )
 
  son_75.histories = 
	JSON.parse(   

	    '[
	        {
	          "created":"2015-03-12T09:22:46.262-0500", 
	          "items":[{
	      	    "field":"status", 
	      	    "fromString":"Defined", 
	      	    "toString":"Selected"
	          }]
	        },{
	          "created":"2015-03-13T09:22:46.262-0500", 
	          "items":[{
	      	    "field":"status", 
	      	    "fromString":"Selected", 
	      	    "toString":"Investigation In-Progress"
	          }]
	        },{
	          "created":"2015-03-15T09:22:46.262-0500", 
	          "items":[{
	      	    "field":"status", 
	      	    "fromString":"Investigation In-Progress", 
	      	    "toString":"Investigation Done"
	          }]
	        },{
	          "created":"2015-03-19T09:22:46.262-0500", 
	          "items":[{
	      	    "field":"Scheduled State", 
	      	    "fromString":"Completed", 
	      	    "toString":"Accepted"
	          },{
	      	    "field":"status", 
	      	    "fromString":"Investigation Done", 
	      	    "toString":"Accepted"
	          }]
	        },{
	          "created":"2015-03-19T09:22:46.262-0500", 
	          "items":[{
	      	    "field":"workflow", 
	      	    "fromString":"Agile Simplified Workflow for Project SON", 
	      	    "toString":"Software Development Workflow"
	          }]
	        }
	      ]'
	)

  it "has key SON-75" do
    expect(son_75.get_key).to be == "SON-75"
  end

  it "is not OOC" do
    expect(son_75).not_to be_ooc
  end

  it "is type of Story" do
  	expect(son_75.get_type).to be == "Story"
  end

  it "has right summary" do
  	expect(son_75.get_summary).to be == "Setup JBOSS 7"
  end

  it "has apropriate transitions" do
    transitions = son_75.get_transitions
    expect(transitions.count).to be == 4
    expect(transitions.last).to be == ["Investigation Done","Accepted", DateTime.parse("2015-03-19T09:22:46.262-0500")]
  end
  
end