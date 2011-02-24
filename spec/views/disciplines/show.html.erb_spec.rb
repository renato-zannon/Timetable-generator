#encoding: utf-8
require 'spec_helper'

describe 'disciplines/show.html.erb' do
  before(:each) do
    @discipline = mock_model('Discipline', :name => "Bases matemáticas",
                                           :code => "BC0001",
                                           :tpi  => "4-0-6")
                                           
    group = mock_model('Group', :name => "A Diurno")
    
    @discipline.stub(:groups).and_return([group])
    assign(:discipline, @discipline)
    render
  end
  
  it "shows the discipline's info" do
    rendered.should contain @discipline.name
    rendered.should contain @discipline.code
    rendered.should contain @discipline.tpi
  end
    
  it "lists every groups for the discipline" do
    @discipline.groups.each do |group|
      rendered.should contain group.name
    end
  end
end
