#encoding: utf-8
require 'spec_helper'

describe 'disciplines/index.html.erb' do
  before do
    d1 = mock_model('Discipline', :name => "Bases matemáticas",
                                  :code => "BC0001",
                                  :tpi  => "4-0-6")
    @disciplines = [d1]
    assign(:disciplines, @disciplines)
  end
  
  it "accesses the 'disciplines' instance variable" do
    @disciplines.should_receive(:each)
    render
  end
  
  it "lists every discipline" do
    render
    rendered.should have_selector("ul") do |list| 
      list.should have_selector("li", :content => "BC0001 - Bases matemáticas (4-0-6)")
    end
  end
  
end
