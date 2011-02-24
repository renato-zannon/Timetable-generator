class DisciplinesController < ApplicationController

  def new
    @discipline = Discipline.new
  end

  def create
    @discipline = Discipline.new(params[:discipline])
    if @discipline.save
      flash[:notice] = "The discipline was saved successfully!"
      redirect_to :action => 'index'
    else
      flash[:error] = "An error occurred when saving the discipline"
      render 'new'
    end
  end

  def index
    @disciplines = Discipline.all
  end
  
  def show
    discipline = Discipline.find(params[:id])
    if discipline.nil?
      flash[:error] = "Discipline with id #{params[:id]} not found!"
      redirect_to disciplines_path
    else
      @discipline = discipline
    end
  end
end
