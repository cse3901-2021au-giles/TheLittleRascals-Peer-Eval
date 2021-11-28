class UsersController < ApplicationController
    def new
        @user = User.new
        @is_temp_user = params[:temp_user]
    end
    
    def index
        @user = User.all
    end 
    
    def create 
        @user = User.new(user_params) 

        if user_params['admin'] == 1
            @user.admin = true
        end 

        if params[:temp_user]
            @user.temp_user = true
            @user.password = "ToBeReset"
        end 

        if @user.save
            # session[:current_user] = @user.id
            if @user.temp_user
                return redirect_to user_path(session[:current_user]), notice: "New student added successful"
            end 
            redirect_to login_path
        else
            render :new
        end
    end 

    def edit
        @user = :current_user 
        @user_info = User.find(session[:current_user])
    end 

    def update
        return redirect_to login_path unless session[:current_user]

        @user = User.find(session[:current_user])
        @user.temp_user = false
        if @user.update(update_params)
            redirect_to user_path(session[:current_user]), notice: "Update successful"
        else 
            redirect_to "/users/#{@user.id}/edit"
        end
    end

    def show
        if params[:id].to_i != session[:current_user].to_i
            redirect_to login_path, notice: "You are not logged in"
        else 
            @user = User.find(session[:current_user])
            if  @user.temp_user
                session[:current_user] = nil if session[:current_user]
                redirect_to login_path, notice: "You are not registered yet, please finish registration to continue"
            end 
            if @user.admin == true
                @students = User.where("admin == false")
            end 
        end
    end 

    def destroy
        User.find(params[:id]).destroy
        redirect_to user_path(session[:current_user]), notice: "Student deleted"
    end 
    private
    def user_params
        params.require(:user).permit(:fname, :lname, :email, :password, :admin)
    end 

    def update_params
        params.require(:current_user).permit(:fname, :lname, :email, :password)
    end 
end
