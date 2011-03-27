#encoding: utf-8
class BestTimetableController < ApplicationController
  include BestTimetableHelper

  caches_action :new
  def new
    @disciplines = Discipline.all
  end

  def generate
    if selected_codes.empty?
      flash[:error] = "Nenhuma disciplina foi selecionada!"
      redirect_to :action => :new
    elsif selected_codes.count>7
      flash[:error] = "Por favor, selecione no máximo 7 disciplinas"
      redirect_to :action => :new
    else
      @timetables = BestTimetable.generate Hash[chosen_disciplines]
      if @timetables.nil? or @timetables.empty?
        flash[:error] = "Não foi possível gerar nenhum horário! Seja menos restritivo e/ou cadastre mais turmas e tente novamente"
        redirect_to :action => :new
      end
    end
  end

  private

  def selected_codes
    disciplines = params[:disciplines] || {}
  end

  def chosen_disciplines
    selected_codes.map do |code, inclusion|
      discipline = Discipline.find_by_code code
      [discipline, inclusion]
    end
  end

end
