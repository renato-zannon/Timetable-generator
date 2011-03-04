Given /^a group named "([^"]*)" with the following lessons:$/ do |name, table|
  lessons_table = parse_lessons_table(table)
  @group_params = {:name => name, :lessons => lessons_table}
end

When /^I add the group to the system$/ do
  visit new_group_path
  fill_in 'Name', :with => @group_params[:name]
  select "#{@discipline.code} - #{@discipline.name}", :from => "Discipline"
  @group_params[:lessons].each do |day, lessons_on_day|
    lessons_on_day.each {|lesson| check field_with_id("group_lessons_#{day}_#{lesson}")}
  end
  click_button 'Submit'
end

Then /^the group should be listed in the discipline's groups$/ do
  visit discipline_path(@discipline)
  response.should contain @group_params[:name]
end

Given /^a saved group named "([^"]*)", bound to "([^"]*)", and with the following lessons:$/ do |name, discipline, table|
  Given "a group named \"#{name}\" with the following lessons:", table
  @group = Group.new(@group_params)
  @group.discipline = Discipline.find_by_code(discipline)
  @group.save!
end

World(GroupHelpers)

