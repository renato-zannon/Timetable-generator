class GroupsController < ApplicationController

  def new
    @group = Group.new
    @group.discipline = params[:discipline]
    @discipline_options = Discipline.all.map { |d| [d.name, d] }
  end
end
