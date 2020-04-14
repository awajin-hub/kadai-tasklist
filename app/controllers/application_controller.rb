class ApplicationController < ActionController::Base
    include SessionsHelper
    
    private
    
    def require_user_logged_in
        if !logged_in?
            redirect_to login_url
        end
    end
    
    def counts(user)
       @count_tasks = user.tasks.count 
    end
end
