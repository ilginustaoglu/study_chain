class TimersController < ApplicationController
  before_action :require_authenticated_user
  before_action :require_premium_or_admin

  def index
    # Timers artık homes sayfasında gösteriliyor
    redirect_to homes_path
  end

  def show
    @timer = Timer.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @timer }
    end
  end

  def new
    @timer = Timer.new
  end

  def edit
    @timer = Timer.find(params[:id])
  end

  def create
    @timer = Timer.new(timer_params)
    if @timer.save
      respond_to do |format|
        format.html { redirect_to timers_path, notice: "Timer successfully created!" }
        format.json { render json: @timer, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @timer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @timer = Timer.find(params[:id])
    if @timer.update(timer_params)
      respond_to do |format|
        format.html { redirect_to timers_path, notice: "Timer successfully updated!" }
        format.json { render json: @timer }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @timer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @timer = Timer.find(params[:id])
    @timer.destroy
    
    respond_to do |format|
      format.html { redirect_to timers_path, notice: "Timer successfully deleted!" }
      format.json { head :no_content }
    end
  end

  # Timer'ı başlat/duraklat/sıfırla için API endpoint'leri
  def start
    @timer = Timer.find(params[:id])
    @timer.update(is_running: true)
    render json: @timer
  end

  def pause
    @timer = Timer.find(params[:id])
    @timer.update(is_running: false)
    render json: @timer
  end

  def reset
    @timer = Timer.find(params[:id])
    @timer.update(seconds: 0, break_seconds: 0, is_running: false, active_timer: 'study')
    render json: @timer
  end

  def tick
    @timer = Timer.find(params[:id])
    if @timer.is_running
      if @timer.active_timer == 'study'
        @timer.increment!(:seconds)
      elsif @timer.active_timer == 'break'
        @timer.increment!(:break_seconds)
      end
    end
    render json: @timer
  end
  
  def toggle_break
    @timer = Timer.find(params[:id])
    
    if @timer.active_timer == 'study'
      # Break'e geçiş yap
      @timer.update(active_timer: 'break', is_running: true)
    else
      # Study'ye geçiş yap
      @timer.update(active_timer: 'study', is_running: true)
    end
    
    render json: @timer
  end

  private

  def timer_params
    params.require(:timer).permit(:name, :seconds, :is_running, :break_seconds, :active_timer)
  end
end
