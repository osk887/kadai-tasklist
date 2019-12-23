class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(content: :desc)
  end


  def show
    @task = Task.find(params[:id])
  end


  def new
    @task = Task.new
  end


  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_url
    else
      flash.now[:danger] = "作成に失敗しました"
      render :new
    end
  end


  def edit
    @task = Task.find(params[:id])
  end


  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to @task
    else
      flash.now[:danger] = "タスクを更新できませんでした"
      render :edit
    end
  end


  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = "削除されました"
    redirect_to tasks_url
  end



  private

  def task_params
    params.require(:task).permit(:content)
  end


end
