class TasksController < ApplicationController
  before_action :load_task, only: %i[up down]

  def create
    @project = Project.find(params[:task][:project_id])
    @project.tasks.create(task_params.merge(project_order: @project.next_task_order))
    redirect_to(@project)
  end

  def up
    @task.move_up
    respond_to do |format|
      format.html { redirect_to(@task.project) }
      format.json { head :ok }
    end
  end

  def down
    @task.move_down
    respond_to do |format|
      format.html { redirect_to(@task.project) }
      format.json { head :ok }
    end
  end

  private

  def load_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:project_id, :title, :size)
  end
end
