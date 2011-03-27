#encoding: utf-8
class DisciplinesController < ApplicationController

  caches_action :index
  def new
    @discipline = Discipline.new
  end

  def create
    @discipline = Discipline.new(params[:discipline])
    @discipline.save!
    flash[:notice] = "A disciplina foi salva com sucesso!"
    expire_action :action => :index
    redirect_to :action => 'index'
  rescue ActiveRecord::RecordInvalid
    flash[:error] = "Houve erros ao tentar salvar a disciplina"
    render 'new'
  end

  def index
    @disciplines = Discipline.all
  end

  def show
    id = params[:id]
    @discipline = Discipline.find id
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "A disciplina com id #{id} não foi encontrada!"
    redirect_to disciplines_path
  end
end
