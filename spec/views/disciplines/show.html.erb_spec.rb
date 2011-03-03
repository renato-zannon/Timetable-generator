#encoding: utf-8
require 'spec_helper'

describe 'disciplines/show.html.erb' do
  before(:each) do
    @discipline = mock_model('Discipline', :name => "Bases matemáticas",
                                           :code => "BC0001",
                                           :tpi  => "4-0-6")
                                           
    group = mock_model('Group', :name => "A Diurno").as_null_object
    
    @discipline.stub(:groups).and_return([group]*4)
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
