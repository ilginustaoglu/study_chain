class TimersController < ApplicationController
  def index
    @timers = Timer.all.order(created_at: :asc)
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
        format.html { redirect_to timers_path, notice: "Timer başarıyla oluşturuldu!" }
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
        format.html { redirect_to timers_path, notice: "Timer başarıyla güncellendi!" }
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
      format.html { redirect_to timers_path, notice: "Timer başarıyla silindi!" }
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
    @timer.update(seconds: 0, is_running: false)
    render json: @timer
  end

  def tick
    @timer = Timer.find(params[:id])
    @timer.increment!(:seconds) if @timer.is_running
    render json: @timer
  end

  private

  def timer_params
    params.require(:timer).permit(:name, :seconds, :alarm_seconds, :is_running, :alarm_time)
  end
end
