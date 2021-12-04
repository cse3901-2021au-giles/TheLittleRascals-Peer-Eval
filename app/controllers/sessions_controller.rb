class SessionsController < ApplicationController
    def create
        exists = false
        if User.exists?(email: params[:email])
            exists = true
            @user = User.find_by(email: params[:email])
        end
        if exists && @user.temp_user
            session[:current_user] = @user.id
            redirect_to edit_user_path(session[:current_user]),  notice: "Please update your profile to continue"
        elsif exists && @user.authenticate(params[:password])
            session[:current_user] = @user.id
            if @user.admin == true
                redirect_to user_path(session[:current_user]),  notice: "You are logged in as Admin"
                return
            end 
            redirect_to user_path(session[:current_user]),  notice: "You are logged in as student"
        else
            message = "Something is wrong"
            if exists
                message = "Email already in use. Please log in"
            end
            redirect_to login_path, notice: message
        end

    end 

    def destroy
        session[:current_user] = nil if session[:current_user]
        redirect_to login_path, notice: "Logout successful"
    end 

end 