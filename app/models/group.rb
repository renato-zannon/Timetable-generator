require 'lesson_table_validator'

class Group < ActiveRecord::Base
  include GroupConstants

  belongs_to  :discipline

  validates :name,          :presence => true, :uniqueness => {:scope   => :discipline_id,
                                                               :message => "has been taken by another group on this discipline"}

  validates :discipline_id, :presence => true, :uniqueness => {:scope => WEEK_DAYS.map { |day| 'int_'+day},
                                                               :message => "already has another group with these lessons" }
  validates :lessons,       :presence => true, :lesson_table => true

  def lessons=(lesson)
    lesson = {} unless lesson.respond_to? '[]'
    week_days.each do |day|
      lesson[day] = day_hash_to_array(lesson[day]) if lesson[day].kind_of? Hash
      lesson[day] ||= Array.new
      self.send("int_#{day}=", IntTools.int_from_lessons(lesson[day]) )
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
