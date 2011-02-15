#encoding: utf-8
require 'spec_helper'

describe DisciplinesController do

  before(:each) do 
    @new_discipline = mock_model('Discipline').as_new_record
  end
  
  describe "GET 'new'" do
    it "sets an instance variable with an new discipline" do
      Discipline.should_receive(:new).and_return(@new_discipline)
      get :new
      assigns[:discipline].should == @new_discipline
    end
  end

  describe "GET 'index'" do
    it "reads all the disciplines from the database" do
      Discipline.should_receive(:all)
      get :index
    end
    
    it "sets an instance variable with the disciplines read" do
      Discipline.stub(:all).and_return([@new_discipline])
      get :index
      assigns[:disciplines].should == [@new_discipline]
    end
  end
  
  describe "GET 'create'" do
                      
    it "instantiates a new discipline with the provided parameters"     
    it "saves the created discipline"
    context "when the discipline is saved successfully" do
      it "sets a 'success' flash message"
      it "redirects to the disciplines index page"
    end
    context "when the discipline fails to save" do
      it "sets an instance variable with the previous parameters"
      it "sets an error flash message"
      it "renders the 'new' page"
     end
  end
  
end
