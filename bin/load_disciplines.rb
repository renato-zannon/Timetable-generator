#encoding: utf-8
require 'yaml'
require 'group_constants'

class DisciplineLoader
  class << self
include GroupConstants

    def days
      {'Segunda' => "monday", 'Terça' => "tuesday", 'Quarta' => "wednesday", "Quinta" => "thursday", "Sexta" => "friday", "Sábado" => "saturday"}
    end

    def discipline_from(record)
      unless discipline = Discipline.find_by_code(record[:codigo])
        discipline = Discipline.new
        discipline.code = record[:codigo]
        discipline.name = record[:nome]
        discipline.tpi  = [record[:t], record[:p], record[:i]].join('-')
        discipline.save!
      end
      discipline
    end

    def group_from(record)
      group = Group.new
      group.name = [record[:turma], record[:turno]].join(' - ')
      group.discipline = Discipline.find_by_code(record[:codigo])
      puts record[:codigo]
      record[:horarios].each do |horario|
        group.lessons = group.lessons.merge(parse_lesson(horario)) { |key, existing, new| existing + new }
      end
      begin
        group.save! 
      rescue
        return nil
      end
      return group
    end

    def parse_lesson(horario)
      fields = horario.scan(/^([[:alpha:]çá]+)(?:-feira)? das (\d{2}:\d{2}) às (\d{2}:\d{2})/i)[0] 
      if fields[2] == "23:00"
        fields[2] = "22:30"
      else
        fields[2] = all_lessons[all_lessons.index(fields[2])-1]
      end
      lessons = all_lessons.slice(all_lessons.index(fields[1])..all_lessons.index(fields[2]))
      {days[fields[0]] => lessons}
    end

  end
end

records = YAML.load_file 'bin/disciplinas.yml'
records.each do |record|
  discipline = DisciplineLoader.discipline_from(record)
  group = DisciplineLoader.group_from(record)
  discipline.save!
end
