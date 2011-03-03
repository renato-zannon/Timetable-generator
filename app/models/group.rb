require 'lesson_table_validator'

class Group < ActiveRecord::Base
  include GroupConstants
  
  attr_accessible :name, :discipline, :lessons
  belongs_to  :discipline
   
  validates :name,       :presence => true
  validates :discipline, :presence => true
  validates :lessons,    :presence => true, :lesson_table => true
  
  def lessons=(l)
    l = {} unless l.respond_to? '[]'
    week_days.each do |day|
      l[day] = day_hash_to_array(l[day]) if l[day].kind_of? Hash
      l[day] ||= Array.new
      self.send("int_#{day}=", IntTools.int_from_lessons(l[day]) )
    end
  end
  
  def lessons
    week_days.inject({}) do |hash, day|
      hash.merge Hash[day, IntTools.lessons_from_int(send "int_#{day}")]
    end
  end
  
  private
    
  def day_hash_to_array(day_hash)  
    day_hash.reject{ |_, v| v.to_i==0 }.keys
  end
  
end
