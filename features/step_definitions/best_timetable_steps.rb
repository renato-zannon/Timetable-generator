When /^I check "([^"]*)" from the list of disciplines$/ do |code|
  check /#{code}/
end

Then /^I should see a timetable containing the disciplines:$/ do |table|
 codes = table.raw.flatten
 codes.each { |code| response.should contain code}
end
