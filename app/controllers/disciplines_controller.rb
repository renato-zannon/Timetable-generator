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
  
end
