require 'spec_helper'
require 'group_constants'

describe Timetable do
  include GroupConstants
    
  before do
    @group = double('Group')
    @lessons = {"monday"  =>["08:00", "08:30", "09:00", "09:30"], 
              "tuesday"   =>["08:00", "08:30", "09:00", "09:30"], 
              "wednesday" =>["08:00", "08:30", "09:00", "09:30"], 
              "thursday"  =>["08:00", "08:30", "09:00", "09:30"], 
              "friday"    =>["08:00", "08:30", "09:00", "09:30"], 
              "saturday"  =>["08:00", "08:30", "09:00", "09:30"]}
    
    @group.stub(:lessons).and_return @lessons
    week_days.each do |day|
      @group.stub("int_#{day}").and_return 15
    end
    @timetable = Timetable.new [@group]
  end
  
  describe "#has_lessons_after" do
    context "when given only one day" do
      it "returns true if there's a lesson after the given on that day" do
        @timetable.has_lessons_after("08:00",:day => "monday").should be_true
      end
      
      it "returns false if there's no lesson after the given on that day" do
        @timetable.has_lessons_after("10:00",:day => "monday").should be_false
      end
    end
    
    context "when given various daya" do
      it "returns true if there's a lesson after the given on all given days" do
        @timetable.has_lessons_after("08:00",:days => ["monday","saturday"]).should be_true
      end
      
      it "returns false if there's no lesson after the given on any given days" do
        @timetable.has_lessons_after("10:00",:days => ["monday","friday"]).should be_false
      end
    end
    
    context "when no day is given" do
      it "returns true if there's a lesson after on any day" do
        @timetable.has_lessons_after("08:00").should be_true
      end
      
      it "returns false if there's no lesson after on any day" do
        @timetable.has_lessons_after("10:00").should be_false
      end
    end
  end
  
  describe "#lessons_on" do
    it "returns all the lessons on the given day" do
      @timetable.lessons_on("monday").should == @lessons["monday"]
    end
  end
  
  describe "#int_for" do
    it "an int representing all lesson on a given day" do
      @timetable.int_for("monday").should == 15
    end 
  end
  
  describe "#has_group_on" do
    it "returns true if there's a group on the given lesson and day" do
      @timetable.has_group_on("monday", "08:00").should be_true
    end
    
    it "returns false if there's no group on the given lesson and day" do
      @timetable.has_group_on("monday", "22:00").should be_false
    end
  end
  
  describe "#group_on" do
    it "if there's a group on the given parameters, it returns the group" do
      @timetable.group_on("monday","08:00").should == @group
    end
    
    it "if there's no group on the given parameters, it returns null" do
      @timetable.group_on("monday","22:00").should be_nil
    end
  end
  
end
