class GroupsController < ApplicationController

  def new
    @group = Group.new(:discipline_id => params[:discipline_id])
    @discipline_options = Discipline.all.map do |discipline|
      ["#{discipline.code} - #{discipline.name}", discipline.id]
    end
  end

  def create
    group = Group.new(params[:group])
    if group.save == true
      flash[:notice] = "The group was created successfully!"
      redirect_to group
    else
      flash[:error] = "There was an error while saving the group!"
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
