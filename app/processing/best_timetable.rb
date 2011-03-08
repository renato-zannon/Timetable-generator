class BestTimetable

  def BestTimetable.generate(disciplines)
    return nil if disciplines.nil? or disciplines.empty?
    all_groups = all_groups_from(disciplines)
    valid_timetables = all_valid_timetables_from(all_groups)
    valid_timetables.sort_by{ |timetable| -timetable.score }
  end

  private

  def BestTimetable.all_groups_from(disciplines)
    return nil unless disciplines.respond_to? :inject
    disciplines.inject([]) do |groups, discipline|
      groups.concat  discipline.groups
    end
  end

  def BestTimetable.all_valid_timetables_from(groups)
    return nil unless groups.respond_to? :combination
    groups.combination(Discipline.count).inject([]) do |timetables, comb|
      timetable = Timetable.new(comb)
      timetables << timetable if timetable.valid?
      timetables
    end
  end

end
