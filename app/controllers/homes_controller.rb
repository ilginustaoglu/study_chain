class HomesController < ApplicationController
  before_action :require_authenticated_user
  
  def index
    @notes = if current_user.premium? || current_user.admin?
      Note.all.order(created_at: :desc)
    else
      Note.none
    end
    
    @tasks = if current_user.premium? || current_user.admin?
      Task.all.order(created_at: :desc)
    else
      Task.none
    end
    
    @timers = if current_user.premium? || current_user.admin?
      Timer.all.order(created_at: :asc)
    else
      Timer.none
    end
  end

  def show
    @home = Home.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @home }
    end
  end

  def new
    @home = Home.new
  end

  def create
    @home = Home.new(home_params)
    if @home.save
      redirect_to root_path, notice: "Note successfully added!"
    else
      render :new
    end
  end

  def edit
    @home = Home.find(params[:id])
  end

  def update
    @home = Home.find(params[:id])
    if @home.update(home_params)
      redirect_to root_path, notice: "Note successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @home = Home.find(params[:id])
    @home.destroy
    
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Note successfully deleted!" }
      format.json { render json: { message: "Note successfully deleted!" }, status: :ok }
    end
  end

  private

  def home_params
    params.require(:home).permit(:title, :content)
  end
end
