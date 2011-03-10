class GroupsController < ApplicationController

  def new
    @group = Group.new
    @group.discipline = Discipline.find(params[:discipline_id]) unless params[:discipline_id].nil?
    @discipline_options = Discipline.all.map { |d| ["#{d.code} - #{d.name}", d.id] }
  end
  
  def create
    group = Group.new(params[:group])
    group.discipline = Discipline.find(params[:group]['discipline_id'])
    if group.save == true
      flash[:notice] = "The group was created successfully!"
      redirect_to group
    else
      flash[:error] = "There was an error while saving the group!"
      @group = group
      @discipline_options = Discipline.all.map { |d| [d.name, d.id] }
      render :action => :new
    end
  end

  def show
    @group = Group.find(params[:id])    
  end

  def index
    @groups = Group.all(:joins => :discipline, :order => 'disciplines.name')
  end

end
