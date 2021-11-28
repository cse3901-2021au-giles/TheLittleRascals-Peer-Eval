class SessionsController < ApplicationController
    def create
        @user = User.find_by(email: params[:email])
        if !!@user && @user.temp_user
            session[:current_user] = @user.id
            redirect_to edit_user_path(session[:current_user]),  notice: "Please update your profile to continue"
        elsif !!@user && @user.authenticate(params[:password])
            session[:current_user] = @user.id
            if @user.admin == true
                redirect_to user_path(session[:current_user]),  notice: "You are logged in as Admin"
                return
            end 
            redirect_to user_path(session[:current_user]),  notice: "You are logged in as student"
        else 
            message = "Something is wrong"
            redirect_to login_path, notice: message
        end

    end 

    def destroy
        session[:current_user] = nil if session[:current_user]
        redirect_to login_path, notice: "Logout successful"
    end 

end 