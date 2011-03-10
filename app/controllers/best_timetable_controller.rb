class BestTimetableController < ApplicationController
  include BestTimetableHelper

  def new
    @disciplines = Discipline.all
  end

  def generate
    if params[:disciplines].nil?
      flash[:error] = "no discipline was selected!"
      @disciplines = Discipline.all
      render :new
    else
      @timetables = BestTimetable.generate(chosen_disciplines)
    end
  end
end
