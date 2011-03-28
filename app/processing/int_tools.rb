require 'group_constants'
class IntTools

  def self.all_lessons
    @all_lessons ||= Hash[GroupConstants::ALL_LESSONS.map.with_index { |l, idx| [l, 2**idx] }]
  end

  def self.index_for_lesson(lesson)
    @index_for_lesson ||= {}
    @index_for_lesson[lesson] ||= GroupConstants::ALL_LESSONS.index(lesson)
  end

  def self.int_from_lesson(lesson)
    all_lessons[lesson] || 0
  end

  def self.lesson_from_int(int)
    return nil if int<=0
    all_lessons[int.to_s(2).size]
  end

  def self.int_from_lessons(lessons_array)
    return 0 unless lessons_array.respond_to? :inject
    lessons_array.inject(0) { |sum, time| sum + int_from_lesson(time) }
  end

  def self.lessons_from_int(int)
    @lessons_from_int ||= {}
    @lessons_from_int[int] ||= all_lessons.reject { |lesson, int_lesson| (int_lesson>int) || (int_lesson & int)==0 }.keys
  end

end
