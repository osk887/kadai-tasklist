class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show,:edit]

  def index
    @tasks = current_user.tasks.order(created_at: :desc)
  end


  def show
    @task = current_user.tasks.find(params[:id])
  end


  def new
    @task = Task.new
  end


  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = "タスクを作成しました"
      redirect_to tasks_url
      # tasks_url
    else
      flash.now[:danger] = "作成に失敗しました"
      render :new
    end
  end


  def edit
    @task = current_user.tasks.find(params[:id])
  end


  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      flash[:success] = "タスクを更新しました"
      redirect_to @task
    else
      flash.now[:danger] = "タスクを更新できませんでした"
      render :edit
    end
  end


  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy

    flash[:success] = "削除されました"
    redirect_to tasks_url
  end



  private

  def task_params
    params.require(:task).permit(:content, :status)
  end


  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      flash[:danger] = '権限がありません'
      redirect_to root_url
    end
  end


end
