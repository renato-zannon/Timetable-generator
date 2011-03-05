class BestTimetableController < ApplicationController
  
  def new
    @disciplines = Discipline.all
  end

  def generate
   redirect_to :action => :new
  end
end
