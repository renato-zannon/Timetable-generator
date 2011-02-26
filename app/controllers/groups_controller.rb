class GroupsController < ApplicationController

  def new
    @group = Group.new
    @group.discipline = params[:discipline] 
  end
end
