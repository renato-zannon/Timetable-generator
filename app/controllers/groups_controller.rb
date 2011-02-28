class GroupsController < ApplicationController

  def new
    @group = Group.new
    @group.discipline = params[:discipline]
    @discipline_options = Discipline.all.map { |d| [d.name, d.id] }
  end
  
  def create
    group = Group.new(params[:group])
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
end
