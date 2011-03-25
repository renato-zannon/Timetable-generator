When /^I check "([^"]*)" from the list of disciplines$/ do |code|
  choose field_with_id("disciplines_#{code}_required")
end

Then /^I should see a timetable containing the disciplines:$/ do |table|
 codes = table.raw.flatten
 codes.each { |code| response.should contain code}
end

When /^I visit the best timetable page$/ do
  visit best_timetable_path
end
