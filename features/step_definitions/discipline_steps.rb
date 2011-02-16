Given /^a discipline named "([^"]*)", with code "([^"]*)" and TPI "([^"]*)"$/ do |name, code, tpi|
  @params = {:name => name, :code => code, :tpi => tpi}
end

When /^I add the discipline to the system$/ do
  visit new_discipline_path
  fill_in :name, :with => @params[:name]
  fill_in :code, :with => @params[:code]
  fill_in :tpi,  :with => @params[:tpi]
  click_button "Submit"
end

Then /^the discipline should be saved in the DB$/ do
  visit disciplines_path
  response.should contain "#{@params[:code]} - #{@params[:name]} (#{@params[:tpi]})"
end

Then /^the Discipline inclusion form should be shown again$/ do
  response.should have_selector("form", :method => "post", :id => "new_discipline")
end

Then /^I should receive an error$/ do
  response.should have_selector("div", :class => "flash error")
end

