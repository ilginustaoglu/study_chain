class NotesController < ApplicationController
  before_action :require_authenticated_user
  before_action :require_premium_or_admin

  def index
    @notes = current_user.notes.order(created_at: :desc)
  end

  def show
    @note = current_user.notes.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @note }
    end
  end

  def new
    @note = current_user.notes.build
  end

  def edit
    @note = current_user.notes.find(params[:id])
  end

  def create
    @note = current_user.notes.build(note_params)
    if @note.save
      redirect_to root_path, notice: "Note successfully created!"
    else
      render :new
    end
  end

  def update
    @note = current_user.notes.find(params[:id])
    if @note.update(note_params)
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Note successfully updated!" }
        format.json { render json: @note }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @note = current_user.notes.find(params[:id])
    @note.destroy
    
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Note successfully deleted!" }
      format.json { render json: { message: "Note successfully deleted!" }, status: :ok }
    end
  end

  private

  def note_params
    params.require(:note).permit(:title, :content)
  end
end
