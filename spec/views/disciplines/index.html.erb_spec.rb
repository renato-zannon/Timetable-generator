#encoding: utf-8
require 'spec_helper'

describe 'disciplines/index.html.erb' do
  before do
    @disciplines = [Factory.stub(:discipline)]
    assign(:disciplines, @disciplines)
  end
  
  it "accesses the 'disciplines' instance variable" do
    @disciplines.should_receive(:each)
    render
  end
  
  it "lists every discipline" do
    render
    rendered.should have_selector("ul") do |list| 
      list.should have_selector("li", :content => "#{@disciplines[0].code} - #{@disciplines[0].name} (#{@disciplines[0].tpi})")
    end
  end
  
end
