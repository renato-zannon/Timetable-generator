#encoding: utf-8
require 'spec_helper'

describe 'disciplines/show.html.erb' do
  before(:each) do
    @discipline = Factory.stub(:discipline)
    
    assign(:discipline, @discipline)
    stub_template "shared/_timetable.html.erb" => ""
  end
  
  it "shows the discipline's info" do
    render
    rendered.should contain @discipline.name
    rendered.should contain @discipline.code
    rendered.should contain @discipline.tpi
  end
    
  it "lists every groups for the discipline" do
    render
    @discipline.groups.each do |group|
      rendered.should contain group.name
    end
  end
  
  it "renders the timetable for every group" do
    stub_template "shared/_timetable.html.erb" => 'timetable rendered'
    render
    (rendered.scan /timetable rendered/).count.should == @discipline.groups.count
  end
end
