class NotesController < ApplicationController
  def index
    @notes = Note.all.order(created_at: :desc)
  end

  def show
    @note = Note.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @note }
    end
  end

  def new
    @note = Note.new
  end

  def edit
    @note = Note.find(params[:id])
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      redirect_to root_path, notice: "Note successfully created!"
    else
      render :new
    end
  end

  def update
    @note = Note.find(params[:id])
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
    @note = Note.find(params[:id])
    @note.destroy
    
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Note successfully deleted!" }
      format.json { head :no_content }
    end
  end

  private

  def note_params
    params.require(:note).permit(:title, :content)
  end
end
