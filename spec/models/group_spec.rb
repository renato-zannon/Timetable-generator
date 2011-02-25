require 'spec_helper'

describe Group do
  
  before { mock_model('Discipline') }
  
  let(:valid_params) do
    {:name       => "A Diurno",
     :discipline => Discipline.new,
     :lessons    => lessons}
  end
  
  let(:lessons) do
    {:monday  => ["08:00","08:30","09:00","09:30"],
     :thurday => ["10:00","10:30","11:00","11:30"]}
  end
  
  before(:each) do
    @group = Group.new(valid_params)
  end
  
  it "is valid with valid params" do
    @group.should be_valid
  end
  
  it "is invalid without a discipline" do
    @group.discipline = nil
    @group.should_not be_valid
  end
  
  it "is invalid without a name" do
    @group.name = nil
    @group.should_not be_valid
  end
  
  it "is invalid without lessons" do
    @group.lessons = nil
    @group.should_not be_valid
  end
  
end
