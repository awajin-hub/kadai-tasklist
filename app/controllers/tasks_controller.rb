class TasksController < ApplicationController
before_action :require_user_logged_in, only: [:index, :show]
before_action :correct_user, only:[:destroy, :show, :edit]

    def index
       @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    end
    def create
        @task = current_user.tasks.new(task_params)
        
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
        @task = current_user.tasks.find_by(params[:id])
        
        if @task.update(task_params)
            flash[:success] = "予定更新完了"
            redirect_to @task
        else
            flash.now[:danger] ="これだと更新できないなぁ"
            render :edit
        end
    end
    def destroy
        
        @task.destroy
        
        flash[:success] = "予定は問題なく削除されました"
        redirect_to root_path
    end
    
    private

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

