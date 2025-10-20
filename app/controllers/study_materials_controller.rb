class StudyMaterialsController < ApplicationController
  before_action :require_authenticated_user
  before_action :require_premium_or_admin
  before_action :set_study_material, only: [:show, :edit, :update, :destroy, :remove_file]

  def index
    @study_materials = StudyMaterial.all.order(created_at: :desc)
  end

  def new
    @study_material = StudyMaterial.new
  end

  def create
    @study_material = StudyMaterial.new(study_material_params)
    
    if @study_material.save
      redirect_to study_materials_path, notice: 'Ders notu başarıyla oluşturuldu.'
    else
      render :new
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @study_material }
    end
  end

  def edit
  end

  def update
    if @study_material.update(study_material_params)
      redirect_to study_materials_path, notice: 'Ders notu başarıyla güncellendi.'
    else
      render :edit
    end
  end

  def destroy
    @study_material.destroy
    redirect_to study_materials_path, notice: 'Ders notu silindi.'
  end

  def remove_file
    file = @study_material.files.find(params[:file_id])
    file.purge
    redirect_to study_material_path(@study_material), notice: 'Dosya başarıyla silindi.'
  end

  private

  def set_study_material
    @study_material = StudyMaterial.find(params[:id])
  end

  def study_material_params
    params.require(:study_material).permit(:title, :description, :category, files: [])
  end
end
