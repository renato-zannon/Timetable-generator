module GroupHelpers
  def parse_lessons_table(table)
    table.rows_hash.merge(table.rows_hash) do |day, lessons|
      lessons.split(',')
    end
  end
end
