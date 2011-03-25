class BestTimetableController < ApplicationController
  include BestTimetableHelper

  def new
    @disciplines = Discipline.all
  end

  def generate
    if selected_codes.empty?
      flash[:error] = "no discipline was selected!"
      @disciplines = Discipline.all
      render :new
    else
      @timetables = BestTimetable.generate Hash[chosen_disciplines]
    end
  end

  private

  def selected_codes
    disciplines = params[:disciplines] || {}
    disciplines.reject do |_, inclusion|
      inclusion == 'none'
    end
  end

  def chosen_disciplines
    selected_codes.map do |code, inclusion|
      discipline = Discipline.find_by_code code
      [discipline, inclusion]
    end
  end

end
