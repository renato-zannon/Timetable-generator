class GroupsController < ApplicationController

  def new
    @group = Group.new(:discipline_id => params[:discipline_id])
    @discipline_options = Discipline.all.map do |discipline|
      ["#{discipline.code} - #{discipline.name}", discipline.id]
    end
  end

  def create
    @group = Group.new(params[:group])
    @group.save!
    flash[:notice] = "The group was created successfully!"
    redirect_to @group
  rescue
    flash[:error] = "There was an error while saving the group!"
    #TODO: Research refactor! D:
    @discipline_options = Discipline.all.map do |discipline|
      ["#{discipline.code} - #{discipline.name}", discipline.id]
    end
    render :action => :new
  end

  def show
    @group = Group.find(params[:id])
  end

  def index
    @groups = Group.all(:joins => :discipline, :order => 'disciplines.name')
  end

end
