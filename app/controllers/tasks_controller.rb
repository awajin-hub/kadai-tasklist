class TasksController < ApplicationController
    def index
       @tasks = Task.all
    end
    def create
        @task = Task.new(task_params)
        
        if @task.save
            flash[:success] = "予定入力完了！"
            redirect_to @task
        else
            flash.now[:danger] = "再度入力せよ"
            render :new
        end
    end
    def new
        @task = Task.new
    end
    def edit
        @task = Task.find(params[:id])
    end
    def show
        @task = Task.find(params[:id])
    end
    def update
        @task = Task.find(params[:id])
        
        if @task.update(task_params)
            flash[:success] = "予定更新完了"
            redirect_to @task
        else
            flash.now[:danger] ="これだと更新できないなぁ"
            redirect_to @task
        end
    end
    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        
        flash[:success] = "予定は問題なく削除されました"
        redirect_to tasks_url
    end
    
    private

    def task_params
        params.required(:task).permit(:content)
    end

end

