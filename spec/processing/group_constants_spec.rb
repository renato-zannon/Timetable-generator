require 'spec_helper'

describe GroupConstants do

  include GroupConstants

  describe '.all_lessons' do
    it "returns the ALL_LESSONS constant" do
      all_lessons.should == ALL_LESSONS
    end
  end

  describe '.week_days' do
    it 'returns the WEEK_DAYS constant' do
      week_days.should == WEEK_DAYS
    end
  end
end
