class TasksController < ApplicationController
    def index
        @open_tasks = Task.where(finished: false).reorder('updated_at').reverse_order
        @finished_tasks = Task.where(finished: true).reorder('updated_at').reverse_order
        @num_tasks = @open_tasks.length + @finished_tasks.length
        @open_percentage = @num_tasks > 0 ? 
            (@open_tasks.length.to_f / @num_tasks * 100).ceil : 0
        @finished_percentage = @num_tasks > 0 ? 100 - @open_percentage : 0
    end

    def create
        @task = Task.new(params.require(:task).permit(:description))
        @task.finished = false
        if @task.save
            redirect_to root_path
        else
            render js: "$('#alertCreateError').removeClass('d-none')"
        end
    end

    def update
        @task = Task.find(params[:id])
        @task.update(params.require(:task).permit(:description, :finished))
        redirect_to root_path
    end

    def switch
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

    def reset
        ActiveRecord::Base.connection.execute("TRUNCATE TABLE tasks RESTART IDENTITY;")
        redirect_to root_path
    end
end
