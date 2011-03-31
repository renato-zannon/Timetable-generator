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
    @generates_timetables ||= groups_array[0].inject([]) do |results, initial_group|
      results.concat _generate_timetables_recursive([initial_group], groups_array[1..-1])
    end.map { |groups| Timetable.new(groups.compact) }
  end

  def generates_valid_timetable?(groups)
    return false if groups.nil? or groups.empty?
    Timetable.new(groups.compact).valid?
  end

  def _generate_timetables_recursive(current, pool)
    return [current] if pool.nil? or pool.empty?

    pool[0].inject([]) do |results, group|
      new_pool = pool[1..-1].dup
      generated = _generate_timetables_recursive(current+[group], new_pool)
      results.concat generated.select { |groups| generates_valid_timetable?(groups) }
    end
  end

end
