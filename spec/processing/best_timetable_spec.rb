require 'spec_helper'

describe BestTimetable do
 
  before do
    @disciplines = [Factory.stub(:discipline)]
  end

  describe '.generate' do
    it "returns the generated timetables in order" do
      timetables = {}
      timetables[:good] = double('bad_timetable', :score => 100)
      timetables[:bad]  = double('good_timetable', :score => 1)
      BestTimetable.stub(:all_valid_timetables_from).and_return(timetables.values)
      BestTimetable.generate(@disciplines).first.should == timetables[:good]
      BestTimetable.generate(@disciplines).last.should == timetables[:bad]
    end
    
    it "returns empty array when no timetables are possible" do
      BestTimetable.stub(:all_valid_timetables_from).and_return([])
      BestTimetable.generate(@disciplines).should == [] 
    end
  end
end
