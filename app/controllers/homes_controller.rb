class HomesController < ApplicationController
  
  def index
    @notes = Note.all.order(created_at: :desc)
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
      redirect_to root_path, notice: "Not başarıyla eklendi!"
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
      redirect_to root_path, notice: "Not başarıyla güncellendi!"
    else
      render :edit
    end
  end

  def destroy
    @home = Home.find(params[:id])
    @home.destroy
    
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Not başarıyla silindi!" }
      format.json { render json: { message: "Not başarıyla silindi!" }, status: :ok }
    end
  end

  private

  def home_params
    params.require(:home).permit(:title, :content)
  end
end
