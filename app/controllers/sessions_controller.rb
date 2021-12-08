class SessionsController < ApplicationController
    # Assume the user doesnt exist, but if they do gather their info
    def create
        exists = false
        if User.exists?(email: params[:email])
            exists = true
            @user = User.find_by(email: params[:email])
        end
        # They exist but their profile is incomplete
        if exists && @user.temp_user
            session[:current_user] = @user.id
            redirect_to edit_user_path(session[:current_user]),  notice: "Please update your profile to continue"
        # If the user's profile is complete and they entered the correct password
        elsif exists && @user.authenticate(params[:password])
            session[:current_user] = @user.id
            # Are they an admin? These route different messaages so it matters.
            if @user.admin == true
                redirect_to user_path(session[:current_user]),  notice: "You are logged in as Admin"
                return
            end 
            redirect_to user_path(session[:current_user]),  notice: "You are logged in as student"
        # If we made it here the user either isnt signed up, gave a bad password or general error occurred
        else
            message = "Something is wrong"
            if exists && !@user.authenticate(params[:password])
                message = "Wrong password!"
            elsif !exists
                message = "Email not in use!"
            end

            redirect_to login_path, notice: message
        end

    end
    # Will log the current user out
    def destroy
        session[:current_user] = nil if session[:current_user]
        redirect_to login_path, notice: "Logout successful"
    end 

end 