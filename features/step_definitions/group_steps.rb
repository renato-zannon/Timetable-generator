Given /^a group named "([^"]*)" with the following lessons:$/ do |name, table|
  lessons_table = parse_lessons_table(table)
  @group_params = {:name => name, :lessons => lessons_table}
end

When /^I add the group to the system$/ do
  visit new_group_path
  fill_in :name, :with => @group_params[:name]
  select @discipline.name, :from => "Discipline"
  @group_params[lessons_table].each do |day, lessons|
    within day {lessons.each {|lesson| check lesson} }
  end
  click_button 'submit'
end

Then /^the group should be listed in the discipline's groups$/ do
  visit discipline_path(@discipline)
  response.should contain @group_params[:name]
end

World(GroupHelpers)

