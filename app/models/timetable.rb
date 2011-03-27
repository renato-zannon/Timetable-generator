require 'group_constants'

class Timetable
  include GroupConstants

  attr_accessor :groups

  def initialize(groups_array)
    @groups = groups_array
  end

  def has_lessons_after(lesson, options = {})
    days = extract_days_from(options)
    lesson_int = IntTools.int_from_lesson(lesson)
    days.each do |day|
      return true if lesson_int < int_for(day)
    end
    return false
  end

  def has_lessons_before(lesson, options = {})
    days = extract_days_from(options)
    mask = IntTools.int_from_lesson(lesson)-1
    days.each do |day|
      return true if int_for(day) & mask > 0
    end
    return false
  end

  def week_amplitude
    first_lesson_idx = all_lessons.index { |lesson| has_lessons_before(lesson, :days => week_days-[:saturday]) }
    last_lesson_idx = all_lessons.rindex { |lesson| has_lessons_after(lesson, :days => week_days-[:saturday]) }
    last_lesson_idx - first_lesson_idx rescue 0
  end

  def saturday_amplitude
    return 0 if int_for(:saturday) == 0
    first_lesson_idx = all_lessons.index { |lesson| has_lessons_before(lesson, :day => :saturday) }
    last_lesson_idx = all_lessons.rindex { |lesson| has_lessons_after(lesson, :day => :saturday) }
    last_lesson_idx - first_lesson_idx
  end

  def lessons_table
    first_lesson_idx = all_lessons.index { |lesson| has_lessons_before(lesson) }-1
    last_lesson_idx = all_lessons.rindex { |lesson| has_lessons_after(lesson) }+1
    all_lessons[first_lesson_idx..last_lesson_idx]
  end

  def lessons_on(day)
    @lessons_on ||= {}
    @lessons_on[day] ||= IntTools.lessons_from_int(int_for(day))
  end

  def int_for(day)
    @int_for ||= {}
    @int_for[day] ||= @groups.inject(0) do |sum, group|
      sum = (sum | group.send("int_#{day}"))
    end
  end

  def has_group_on(day, lesson)
    (int_for(day) & IntTools.int_from_lesson(lesson)) > 0
  end

  def group_on(day, lesson)
    return nil unless has_group_on(day,lesson)
    groups.find { |group| group.lessons[day].include? lesson}
  end

  def groups=(groups)
    @groups = groups
  end

  def valid?
    if has_group_collisions? or groups.empty?
      return false
    else
      return true
    end
  end

  def score
    -(5*week_amplitude+2*saturday_amplitude)
  end

  def windows
    @windows ||= week_days.inject(0) do |sum, day|
      sum += windows_on(day)
    end
  end

  def windows_on(day)
    @windows_on ||= {}
    @windows_on[day] ||= (complete_table(day).count - lessons_on(day).count)/2.0
  end

  def complete_table(day)
    @complete_table[day] unless @complete_table.nil? || @complete_table[day].nil?
    @complete_table ||= {}
    first_lesson_idx = all_lessons.index(lessons_on(day).first)
    last_lesson_idx = all_lessons.rindex(lessons_on(day).last)
    @complete_table[day] ||= all_lessons[first_lesson_idx..last_lesson_idx] rescue []
  end

  private

  def has_group_collisions?
    week_days.each do |day|
      @groups.inject(0) do |sum, group|
        int = group.send("int_#{day}")
        return true unless (sum & int)==0
        sum = sum | int
      end
    end
    return false
  end

  def has_duplicated_disciplines?
    @groups.inject([]) do |disciplines, group|
      return true if disciplines.include?(group.discipline)
      disciplines << group.discipline
    end
    return false
  end

  def extract_days_from(options)
    if options[:day]
      [options[:day]]
    elsif options[:days]
      options[:days]
    else
      WEEK_DAYS
    end
  end

end
