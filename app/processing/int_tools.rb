class IntTools
  include GroupConstants

  def self.int_from_lesson(lesson)
    @int_from_lesson ||= {}
    @int_from_lesson[lesson] ||= 2**(ALL_LESSONS.index(lesson))
  end

  def self.lesson_from_int(int)
    return nil if int<=0
    @lesson_from_int ||= {}
    @lesson_from_int[int] ||= ALL_LESSONS[(Math.log2 int).round]
  end

  def self.int_from_lessons(lessons_array)
    return 0 unless lessons_array.respond_to? :inject
    lessons_array.inject(0) { |sum, time| sum + int_from_lesson(time) }
  end

  def self.lessons_from_int(int)
    ALL_LESSONS.select.with_index { |lesson, idx| lesson_from_int(int & 2**idx) }
  end

end
