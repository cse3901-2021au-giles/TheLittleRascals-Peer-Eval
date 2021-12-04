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


    
    def create 
        @user = User.new(user_params)
        exists_error = "This email is already in use! Please sign in."
        if User.exists?(email: @user.email)
            return redirect_to login_path, notice: exists_error
        end

        # alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        # sym = "~`!@#$%^&*()_+-={[}]|\\:;"'<,>.?/'"`"
        # num = "1234567890"
        # password = params[:password]
        # puts("\n\n#{password}\n\n")
        # @bad_password = false
        # @error = "Password must contain an uppercase letter, a symbol and a number!!!"
        # if password.count(/#{alpha}/) < 1 or
        #   password.count(/[#{sym}]/) < 1 or word.count(/[#{num}]/) <1
        #     @bad_password = true
        # end
        
        if user_params['admin'] == 1
            @user.admin = true
        end 
        

        if params[:temp_user]
            @user.temp_user = true
            @user.password = "ToBeReset"
        end 

        if @user.save
            email = @user.email
            puts `\npython3 smtp.py #{email} "2"`
            # fork{exec("python3 smtp.py \"#{email}\" \"1\"")}
            # Kernel.exec("python3 smtp.py #{email} 2")
            # session[:current_user] = @user.id
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
                @grouping = Grouping.where("user_id": session[:current_user]).first
                @group = Group.find(@grouping.group_id)
            end 
        end
    end 

    def destroy
        User.find(params[:id]).destroy
        redirect_to user_path(session[:current_user]), notice: "Student deleted"
    end 
    private
    def user_params
        params.require(:user).permit(:fname, :lname, :email, :password, :admin, :group)
    end 

    def update_params
        params.require(:current_user).permit(:fname, :lname, :email, :password)
    end 
end
