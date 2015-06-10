require 'issue_serializer'
require 'json'
require 'spec_helper'
require 'date'

describe "An Issue Serializer" do
    
  json_issue = JSON.parse(
    '{
      "key":"SON-75", 
      "fields":{
        "issuetype":{
          "name":"Story"
        },
        "summary":"Setup JBOSS 7"
      },
      "changelog":{
        "histories": [
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
        ]
      }
    }'
  )
    
  it "deserializes json attributes as proper issue" do
    issue = IssueSerializer.deserialize json_issue
    
    expect(issue.key).to be == "SON-75"
    expect(issue.summary).to be == "Setup JBOSS 7"
    expect(issue.type).to be == "Story"
    expect(issue.statuses.count).to be == 4
    expect(issue.statuses.last).to be == Status.new("Accepted", DateTime.parse("2015-03-19T09:22:46.262-0500"))
  end  
end