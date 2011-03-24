require 'spec_helper'

describe ClockEnumerator do

  subject { ClockEnumerator.new([[0,1],[0,1]]) }

  let(:combinations) { [[0,0],[0,1],[1,0],[1,1]] }

  describe "#first" do
    it "returns the first combination" do
      subject.first.should == combinations.first
    end
  end

  describe "#last" do
    it "returns the last combination" do
      subject.last.should == combinations.last
    end
  end

  describe "#each" do
    it "yields combinations of the arrays in order" do
      iterator = subject.each
      combinations.each do |combination|
        iterator.next.should == combination
      end
    end
  end

  describe "#all" do
    it "returns all possible combinations" do
      subject.all.should == combinations
    end
  end
end
