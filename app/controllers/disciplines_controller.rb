class DisciplinesController < ApplicationController

  def new
    @discipline = Discipline.new
  end

  def create
  end

  def index
    @disciplines = Discipline.all
  end
  
end
