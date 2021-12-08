class UsersController < ApplicationController
    def new
        @user = User.new
        # if temp_user is checked, true does not imply value true, but string "true" as a checkmark
        @is_temp_user = params[:temp_user] 
        @group_id = params[:group_id]
    end
    
    def index
        @user = User.all
    end
    # This from the create account page and also when the teacher is adding a new student.
    def create 
        @user = User.new(user_params)

        # If the user already exists, we dont want to duplicate their account so redirect to login
        exists_error_at_create = "This student is already created but we have added them to your group!"
        if User.exists?(email: @user.email) && session[:current_user]
            @grouping = Grouping.new
            @grouping.group_id = params[:group_id]
            @grouping.user_id = @user.id
            @grouping.save
            return redirect_to user_path(session[:current_user]), notice: exists_error_at_create
        end 

        if User.exists?(email: @user.email)
            return redirect_to login_path, notice: "User already exist please login"
        end 

        # We want to check their password to make sure that it is strong. If not, dont move on
        alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        sym = "~`!@#$%^&*()_+-={[}]|\\:;"'<,>.?/'"`"
        num = "1234567890"
        password = @user.password.to_s
        @error = "Password must contain an uppercase letter, a symbol, a number and be 8 in length!!!"
        if password.count(alpha) < 1 or password.length < 8 or
          password.count(sym) < 1 or password.count(num) < 1
            return render :new
        end
        # If the checkbox is filled, make the account an admin
        if user_params['admin'] == 1
            @user.admin = true
        end 
        
        # If the teacher created the account send the correct email, otherwise send default creation email
        if params[:temp_user]
            @user.temp_user = true
            @user.password = "ToBeReset"
            email = @user.email
            puts `\npython3 smtp.py #{email} "4"`
        else
            email = @user.email
            puts `\npython3 smtp.py #{email} "2"`
        end 
        # Save the user and redirect, if teacher signed you up. Fill in the group fields
        if @user.save
            if @user.temp_user

                @grouping = Grouping.new
                @grouping.group_id = params[:group_id]
                @grouping.user_id = @user.id
                @grouping.save


                return redirect_to user_path(session[:current_user]), notice: "New student added successful"
            end 
            redirect_to login_path
        else
            render :new
        end
        # If the user is the administrator and doesnt have a group, make a group of one
        if @user.admin && !params[:has_group]
            @group = Group.new

            @group.name = params[:group]
            @group.size = 1
            @group.owner = @user.id
            @group.save

            # creating grouping relationship
            @grouping = Grouping.new

            puts "Creating new grouping-------------------------------------"
            puts params[:group]
            @grouping.group_id = @group.id
            @grouping.user_id = @user.id
            @grouping.save
        end 
    end 
    # First find the current user and then fill in their new params
    def edit
        @user = :current_user 
        @user_info = User.find(session[:current_user])
    end
    # Make sure that it is a session and only then do you update params
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
    # We only show if the user is valid and logged in
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
                @grouping = Grouping.where("user_id": session[:current_user]).first
                @group = Group.find(@grouping.group_id)
            end 
        end
    end 
    # This will delete the account
    def destroy
        User.find(params[:id]).destroy
        redirect_to user_path(session[:current_user]), notice: "Student deleted"
    end
    # This gathers and enforces the parameters in the front-end forms
    private
    def user_params
        params.require(:user).permit(:fname, :lname, :email, :password, :admin, :group)
    end 
    # Make sure all of the params are there
    def update_params
        params.require(:current_user).permit(:fname, :lname, :email, :password)
    end 
end
