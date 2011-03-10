module BestTimetableHelper

  def chosen_disciplines
    disciplines = params[:disciplines] || {}
    disciplines.keys.map do |code|
      Discipline.find_by_code code || next
    end
  end
end
