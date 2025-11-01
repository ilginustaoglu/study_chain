class TasksController < ApplicationController
  before_action :require_authenticated_user
  before_action :require_premium_or_admin

  def index
    @tasks = current_user.tasks.order(created_at: :desc)
  end

  def show
    @task = current_user.tasks.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @task }
    end
  end

  def new
    @task = current_user.tasks.build
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to root_path, notice: "Task successfully created!"
    else
      render :new
    end
  end

  def update
    @task = current_user.tasks.find(params[:id])
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
    @task = current_user.tasks.find(params[:id])
    @task.update(completed: !@task.completed)
    respond_to do |format|
      format.json { render json: @task }
    end
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
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

