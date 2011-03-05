class BestTimetableController < ApplicationController
  
  def new
    @disciplines = Discipline.all
  end

end
