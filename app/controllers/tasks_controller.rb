class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end

    def create
        @task = Task.new(params.require(:task).permit(:description))
        @task.save
    end
end
