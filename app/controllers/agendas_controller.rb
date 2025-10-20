class AgendasController < ApplicationController
  before_action :require_authenticated_user
  before_action :require_premium_or_admin
  before_action :set_agenda, only: [:show, :edit, :update, :destroy]

  def index
    @agendas = Agenda.order(:event_date)
    @agenda = Agenda.new
  end

  def new
    @agenda = Agenda.new
  end

  def create
    @agenda = Agenda.new(agenda_params)
    
    if @agenda.save
      redirect_to agendas_path, notice: 'Etkinlik eklendi.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @agenda.update(agenda_params)
      redirect_to agendas_path, notice: 'Etkinlik güncellendi.'
    else
      render :edit
    end
  end

  def destroy
    @agenda.destroy
    redirect_to agendas_path, notice: 'Etkinlik silindi.'
  end

  private

  def set_agenda
    @agenda = Agenda.find(params[:id])
  end

  def agenda_params
    params.require(:agenda).permit(:title, :description, :event_date)
  end
end
