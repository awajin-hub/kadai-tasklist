class TasksController < ApplicationController
before_action :set_task, only: [:show, :edit, :update, :destroy]
before_action :require_user_logged_in, only: [:index, :show, :new, :edit, :create]
before_action :correct_user, only: [:destroy, :edit]
#↑にcreateはいれてはならない

    def index
       @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    end
    def create
        @task = current_user.tasks.new(task_params)
        
        if @task.save
            flash[:success] = "タスク入力完了！"
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
    end
    
    def show
    end
    
    def update
        #@task = current_user.tasks.find_by(params[:id])
        
        if @task.update(task_params)
            flash[:success] = "タスク更新完了"
            redirect_to @task
        else
            flash.now[:danger] ="これだと更新できないなぁ"
            render :edit
        end
    end
    def destroy
        
        @task.destroy
        
        flash[:success] = "タスクは問題なく削除されました"
        redirect_to root_path
    end
    
    private
    
    def set_task
       @task = Task.find(params[:id]) 
    end

    def task_params
        params.required(:task).permit(:content, :status)
    end

    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
            redirect_to root_url
        end
    end
    
end

