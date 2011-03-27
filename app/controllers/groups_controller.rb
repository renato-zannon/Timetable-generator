class GroupsController < ApplicationController

  caches_action :index
  def new
    @group = Group.new(:discipline_id => params[:discipline_id])
    @discipline_options = Discipline.all.map do |discipline|
      ["#{discipline.code} - #{discipline.name}", discipline.id]
    end
  end

  def create
    @group = Group.new(params[:group])
    @group.save!
    flash[:notice] = "A turma foi salva com sucesso!"
    expire_action :action => :index
    redirect_to @group
  rescue
    flash[:error] = "Houve erros ao tentar salvar a disciplina!"
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
