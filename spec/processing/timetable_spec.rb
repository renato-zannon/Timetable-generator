require 'spec_helper'
require 'group_constants'

describe Timetable do
  include GroupConstants

  before do
    @group     = Factory.stub(:group)
    @lessons   = Factory(:lessons)
    @timetable = Timetable.new [@group]
  end

  describe "#has_lessons_after" do
    context "when given only one day" do
      it "returns true if there's a lesson after the given on that day" do
        @timetable.has_lessons_after(:"08:00",:day => :"monday").should be_true
      end

      it "returns false if there's no lesson after the given on that day" do
        @timetable.has_lessons_after(:"10:00",:day => :"monday").should be_false
      end
    end

    context "when given various days" do
      it "returns true if there's a lesson after the given on all given days" do
        @timetable.has_lessons_after(:"08:00",:days => [:"monday",:"saturday"]).should be_true
      end

      it "returns false if there's no lesson after the given on any given days" do
        @timetable.has_lessons_after(:"10:00",:days => [:"monday",:"friday"]).should be_false
      end
    end

    context "when no day is given" do
      it "returns true if there's a lesson after on any day" do
        @timetable.has_lessons_after(:"08:00").should be_true
      end

      it "returns false if there's no lesson after on any day" do
        @timetable.has_lessons_after(:"12:00").should be_false
      end
    end
  end

  describe "#lessons_on" do
    it "returns all the lessons on the given day" do
      @timetable.lessons_on(:"monday").should == @lessons[:"monday"]
    end
  end

  describe "#int_for" do
    it "an int representing all lesson on a given day" do
      @timetable.int_for(:"monday").should == 15
    end
  end

  describe "#has_group_on" do
    it "returns true if there's a group on the given lesson and day" do
      @timetable.has_group_on(:"monday", :"08:00").should be_true
    end

    it "returns false if there's no group on the given lesson and day" do
      @timetable.has_group_on(:"monday", :"22:00").should be_false
    end
  end

  describe "#group_on" do
    it "if there's a group on the given parameters, it returns the group" do
      @timetable.group_on(:"monday",:"08:00").should == @group
    end

    it "if there's no group on the given parameters, it returns null" do
      @timetable.group_on(:"monday",:"22:00").should be_nil
    end
  end

  describe '#valid?' do
    it 'returns false if the timetable has two groups of the same discipline' do
      discipline = Factory.stub(:discipline)
      group1 = Factory.stub(:group, :discipline => discipline)
      group2 = Factory.stub(:group, :discipline => discipline)
      @timetable.groups = [group1, group2]
      @timetable.should_not be_valid
    end

    it 'returns false if the timetable has two groups on the same lesson' do
      group1 = Factory.stub(:group, :lessons => @lessons)
      group2 = Factory.stub(:group, :lessons => @lessons)
      @timetable.groups = [group1, group2]
      @timetable.should_not be_valid
    end

    it 'returns true with valid parameters' do
      @timetable.should be_valid
    end
  end
end
