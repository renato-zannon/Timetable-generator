require 'group_constants'

module GroupsHelper

  include GroupConstants
  
  def lessons_boxes(f)
    week_days.each do |day|
      concat (content_tag :div, :class => "Day", :id => day do
        concat content_tag :h3, day
        concat print_lessons_on(day, f)
      end)
    end
  end
  
  def print_lessons_on(day, f)
    f.fields_for day do |day_fields|
      all_lessons.each do |l|
        concat(day_fields.label l)
        concat(day_fields.check_box l)
        concat(tag :br)
      end
    end
  end
  
end
