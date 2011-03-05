When /^I check "([^"]*)" from the list of disciplines$/ do |code|
  visit best_timetable_path
  check /#{code}/
  click_button 'Submit'
end
