require 'spec/spec_helper'
require 'pp'

describe "Sphinx Attribute Searches" do
  before :each do
    @client = Riddle::Client.new("localhost", 3313)
  end
  
  it "should return strings stored in the index" do
    response = @client.query("apple", "thing")
    response[:attributes].values.first.should == Riddle::Client::AttributeTypes[:string]
    response[:matches].first[:attributes]["name"].should == "Apple"
  end
end