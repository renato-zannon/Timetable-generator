require 'lesson_table_validator'
require 'group_constants'

class Group < ActiveRecord::Base
  include GroupConstants
  
  attr_accessible :name, :discipline, :lessons
  belongs_to  :discipline
   
  validates :name,       :presence => true
  validates :discipline, :presence => true
  validates :lessons,    :presence => true, :lesson_table => true
  
  def lessons=(lessons)
    lessons = {} unless lessons.respond_to? '[]'
    week_days.each do |day|
      lessons[day] = day_hash_to_array(lessons[day]) if lessons[day].kind_of? Hash
      
      self.send("int_#{day}=", parse_int_from_lessons(lessons[day]) )
    end
  end
  
  def lessons
    week_days.inject({}) do |hash, day|
      hash.merge Hash[day, parse_lessons_from_int(send "int_#{day}")]
    end
  end
  
  private
  
  def parse_int_from_lessons(lessons_array)
    return 0 unless lessons_array.respond_to? :inject
    lessons_array.inject(0) { |sum, time| sum + (2**all_lessons.index(time)) }
  end
  
  def parse_lessons_from_int(int)
    all_lessons.select.with_index { |lesson, idx| (int & 2**idx)==2**idx }
  end
  
  def day_hash_to_array(day_hash)  
    day_hash.reject{ |_, v| v.to_i==0 }.keys
  end
  
end
