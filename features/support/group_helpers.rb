module GroupHelpers
  def parse_lessons_table(table)
    lessons_table = {}
    table.rows_hash.each do |day, lessons|
      lessons = lessons.split(',')
      lessons_table.merge(day => lessons)
    end
  end
end
