module ApplicationHelper
    # Return whether or not currently logged in
    def logged_in?
        !!session[:user_id]
    end
    # If we cant gather the current user then they cant be logged in
    def current_user
        @current_user ||= User.find_by_id(session[:user_id]) if !!session[:user_id]
    end 
end

