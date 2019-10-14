class TasksController < ApplicationController
    def index
        @open_tasks = Task.where(finished: false).reorder('updated_at').reverse_order
        @finished_tasks = Task.where(finished: true).reorder('updated_at').reverse_order
    end

    def create
        @task = Task.new(params.require(:task).permit(:description))
        @task[:finished] = false
        @task.save
        redirect_to root_path
    end

    def update
        @task = Task.find(params[:id])
        @task.finished = !@task.finished
        @task.save
        redirect_to root_path
    end

    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        redirect_to root_path
    end
end
