require 'spec_helper'

describe DisciplinesController do

  describe "GET 'new'" do
    it "sets an instance variable with an new discipline"
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
