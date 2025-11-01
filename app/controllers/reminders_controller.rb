class RemindersController < ApplicationController
  before_action :require_authenticated_user
  before_action :require_premium_or_admin
  before_action :set_reminder, only: [:show, :edit, :update, :destroy, :toggle_alarm]

  def index
    @reminders = current_user.reminders.order(:alarm_time)
    @reminder = current_user.reminders.build
  end

  def new
    @reminder = current_user.reminders.build
  end

  def create
    @reminder = current_user.reminders.build(reminder_params)
    @reminder.is_active = true if @reminder.is_active.nil?
    
    if @reminder.save
      redirect_to reminders_path, notice: 'Hatırlatıcı oluşturuldu.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @reminder.update(reminder_params)
      redirect_to reminders_path, notice: 'Hatırlatıcı güncellendi.'
    else
      render :edit
    end
  end

  def destroy
    @reminder.destroy
    redirect_to reminders_path, notice: 'Hatırlatıcı silindi.'
  end

  def toggle_alarm
    @reminder.update(is_active: !@reminder.is_active)
    redirect_to reminders_path, notice: "Alarm #{@reminder.is_active ? 'aktif' : 'devre dışı'}."
  end

  private

  def set_reminder
    @reminder = current_user.reminders.find(params[:id])
  end

  def reminder_params
    params.require(:reminder).permit(:title, :description, :alarm_time, :is_active)
  end
end
