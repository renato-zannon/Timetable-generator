require 'spec_helper'

describe Discipline do
  describe "#tpi" do
    it "accepts values on the T-P-I format"
    it "doesn't accept values not on the T-P-I format"
    it "sets the #teoric_hours attribute with the T from T-P-I"
    it "sets the #practical_hours attribute with the P from T-P-I"
    it "sets the #individual_hours attribute with the I from T-P-I"
  end
end
