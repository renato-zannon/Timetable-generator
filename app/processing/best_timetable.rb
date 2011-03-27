require 'clock_enumerator'
class BestTimetable

  attr_reader :disciplines

  def BestTimetable.generate(disciplines)
    return nil if disciplines.nil? or disciplines.empty?
    generator = BestTimetable.new(disciplines)
    generator.timetables
  end

  def initialize(disciplines)
    @disciplines = disciplines
  end

  def timetables
    generated_timetables.sort_by(&:score).reverse
  end

  private

  def groups_array
    @groups_array ||= disciplines.map do |discipline, option|
      discipline.groups + (option == 'required' ? [] : [nil])
    end
  end

  def generated_timetables
    validation = ->groups do
      Timetable.new(groups.compact).valid?
    end

    enumerator = ClockEnumerator.new(groups_array, &validation)
    enumerator.all.map do |groups|
      Timetable.new groups.compact
    end
  end

end
