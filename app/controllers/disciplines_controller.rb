class DisciplinesController < ApplicationController

  def new
    @discipline = Discipline.new
  end

  def create
    @discipline = Discipline.new(params[:discipline])
    @discipline.save!
    flash[:notice] = "The discipline was saved successfully!"
    redirect_to :action => 'index'
  rescue ActiveRecord::RecordInvalid
    flash[:error] = "An error occurred when saving the discipline"
    render 'new'
  end

  def index
    @disciplines = Discipline.all
  end

  def show
    id = params[:id]
    @discipline = Discipline.find id
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Discipline with id #{id} not found!"
    redirect_to disciplines_path
  end
end
