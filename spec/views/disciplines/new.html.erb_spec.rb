require 'spec_helper'

describe 'disciplines/new.html.erb' do
  before(:each) do 
    assign(:discipline, mock_model('Discipline').as_null_object.as_new_record)
    render
  end
  
  it "renders a form for the new discipline" do
    rendered.should have_selector("form", 
                                  :method => "post",
                                  :action => disciplines_path)
  end
  
  it "renders a text field and a label for the discipline name" do
    rendered.should have_selector("form") do |f|
      f.should have_selector("label", :content => "Name", :for => "discipline_name")
      f.should have_selector("input", :type => "text", :name => "discipline[name]")
    end
  end
  
  it "renders a text field and a label for the discipline code" do
    rendered.should have_selector("form") do |f|
      f.should have_selector("label", :content => "Code", :for => "discipline_code")
      f.should have_selector("input", :type => "text", :name => "discipline[code]")
    end
  end
  
  it "renders a text field and a label for the discipline TPI" do
    rendered.should have_selector("form") do |f|
      f.should have_selector("label", :content => "TPI", :for => "discipline_tpi")
      f.should have_selector("input", :type => "text", :name => "discipline[tpi]")
    end
  end
  
  it "renders a submit button" do
    rendered.should have_selector("form") do |f|
      f.should have_selector("input", :type => "submit", :value => "Submit")
    end
  end
end
