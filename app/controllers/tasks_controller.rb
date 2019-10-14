class TasksController < ApplicationController
    #skip_before_action :verify_authenticity_token

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
        if params[:finished] == 'true'
            @task.finished = true
        else
            @task.finished = false
        end
        @task.save
        redirect_to root_path
    end
end
