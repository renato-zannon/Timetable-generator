require 'group_constants'

module GroupsHelper

  include GroupConstants
  
  def timetable_hash(groups_array)
    timetable = Hash.new {|hash,key| hash[key] = Hash.new}
    groups_array.each do |group|
      group.lessons.each do |day, lessons|
        lessons.each {|l| timetable[day][l] = group}
      end
    end
    timetable
  end
  
end
