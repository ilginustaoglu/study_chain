class TasksController < ApplicationController
  before_action :require_authenticated_user
  before_action :require_premium_or_admin

  def index
    @tasks = Task.all.order(created_at: :desc)
  end

  def show
    @task = Task.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @task }
    end
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path, notice: "Task successfully created!"
    else
      render :new
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Task successfully updated!" }
        format.json { render json: @task }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def toggle
    @task = Task.find(params[:id])
    @task.update(completed: !@task.completed)
    respond_to do |format|
      format.json { render json: @task }
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Task successfully deleted!" }
      format.json { render json: { message: "Task successfully deleted!" }, status: :ok }
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :completed)
  end
end

