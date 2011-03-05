When /^I check "([^"]*)" from the list of disciplines$/ do |code|
  visit best_timetable_path
  check /#{code}/
  click_button 'Submit'
end

Then /^I should see a timetable containing the disciplines:$/ do |table|
 codes = table.raw.flatten
 codes.each { |code| response.should contain code}
end
