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
    let(:params) do {"name" => "Bases Matemáticas",
                     "code" => "BC0001",
                     "tpi"  => "4-0-6"} end

    before do
      @new_discipline = Factory.build(:discipline)
      Discipline.stub(:new).and_return(@new_discipline)
    end

    it "instantiates a new discipline with the provided parameters" do
      Discipline.should_receive(:new).with(params).and_return(@new_discipline)
      post :create, :discipline => params
    end

    it "saves the created discipline" do
      post :create, :discipline => params
      @new_discipline.should_not be_new_record
    end

    context "when the discipline is saved successfully" do
      before do
        @new_discipline.stub(:save).and_return(true)
        post :create
      end

      it "sets a 'success' flash message" do
        flash[:notice].should =~ /success/
      end

      it "redirects to the disciplines index page" do
        response.should redirect_to :action => 'index'
      end

    end

    context "when the discipline fails to save" do
      before do
        @new_discipline.stub(:valid?).and_return false
        post :create, :discipline => params
      end

      it "sets an instance variable with the previous parameters" do
        assigns[:discipline].should eq @new_discipline
      end

      it "sets an error flash message" do
        flash[:error].should =~ /error/
      end

      it "renders the 'new' page" do
        response.should render_template :new
      end

     end
  end

  describe "GET 'show'" do
    before { @params ||= {:id => 1} }

    context "when the discipline exists" do
      before do
        Discipline.stub(:exists?).and_return true
        Discipline.stub(:find).and_return @new_discipline
      end

      it "sets an instance variable with the discipline's info" do
        get :show, @params
        assigns[:discipline].should == @new_discipline
      end

    end

    context "when the discipline doesn't exist" do
      before do
        Discipline.stub(:find).and_raise ActiveRecord::RecordNotFound
        get :show, @params
      end

      it "sets an error flash message" do
        flash[:error].should =~ /not found/
      end

      it "redirects to the disciplines index page" do
        response.should redirect_to disciplines_path
      end
    end
  end
end
