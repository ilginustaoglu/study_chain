class FlashcardCollectionsController < ApplicationController
  before_action :require_authenticated_user
  before_action :require_premium_or_admin
  before_action :set_collection, only: [:show, :edit, :update, :destroy, :add_card, :remove_card]

  def index
    @collections = current_user.flashcard_collections.order(created_at: :desc)
  end

  def new
    @collection = current_user.flashcard_collections.build
  end

  def create
    @collection = current_user.flashcard_collections.build(collection_params)
    
    if @collection.save
      redirect_to flashcard_collections_path, notice: 'Koleksiyon başarıyla oluşturuldu.'
    else
      render :new
    end
  end

  def show
    @flashcards = @collection.flashcards.order(created_at: :desc)
    @flashcard = Flashcard.new
  end

  def edit
  end

  def update
    if @collection.update(collection_params)
      redirect_to flashcard_collections_path, notice: 'Koleksiyon güncellendi.'
    else
      render :edit
    end
  end

  def destroy
    @collection.destroy
    redirect_to flashcard_collections_path, notice: 'Koleksiyon silindi.'
  end

  def add_card
    @flashcard = @collection.flashcards.build(flashcard_params)
    
    if @flashcard.save
      redirect_to flashcard_collection_path(@collection), notice: 'Kart eklendi.'
    else
      @flashcards = @collection.flashcards.order(created_at: :desc)
      render :show
    end
  end

  def remove_card
    @flashcard = @collection.flashcards.find(params[:card_id])
    @flashcard.destroy
    redirect_to flashcard_collection_path(@collection), notice: 'Kart silindi.'
  end

  private

  def set_collection
    @collection = current_user.flashcard_collections.find(params[:id])
  end

  def collection_params
    params.require(:flashcard_collection).permit(:title, :description)
  end

  def flashcard_params
    params.require(:flashcard).permit(:front, :back)
  end
end
