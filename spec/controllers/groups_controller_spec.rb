require 'spec_helper'

describe GroupsController do
  
  let(:group) { mock_model('Group').as_new_record.as_null_object }
  
  describe "GET new" do
    before do
      Group.stub(:new).and_return(group)
    end
    
    it "sets @group with a new group" do
      Group.should_receive(:new)
      get :new
      assigns[:group].should == group
    end
    
    context "when a discipline is received via params" do
      it "assigns the new group to the discipline" do
        discipline = double('Discipline')
        group.should_receive('discipline=').with(discipline)
        get :new, :discipline => discipline
      end
    end
  end
  
end
