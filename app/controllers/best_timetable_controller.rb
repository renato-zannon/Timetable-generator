class BestTimetableController < ApplicationController

  def new
    @disciplines = Discipline.all
  end

  def generate
    params[:disciplines] ||= {}
    disciplines = params[:disciplines].keys.map do |code|
      Discipline.find_by_code code || next
    end
    
    if disciplines.empty?
      flash[:error] = "no discipline was selected!"
      @disciplines = Discipline.all
      render :new
    else
      @timetable = BestTimetable.generate(disciplines)
      redirect_to :action => :new
    end
  end
end
