class ProjectsController < ApplicationController
    # Prepare the fields so that we can make the project
    def new
        @group_id = params[:group_id]
        @project = Project.new
    end
    # Fill in the appropriate fields and redirect to users home
    def create
        @project = Project.new(project_params)
        @project.group_id = params[:group_id]
        @project.has_team = false
        if @project.save
            return redirect_to user_path(session[:current_user]), notice: "New project created successful"
        else
            puts "-------------------------"
            render :new
        end
    end
    # We want to display all projects and the users within them
    def show
        @project = Project.find(params['project_id'])
        @user = User.find(params['user_id'])
    end 
    # Called to delete the project
    def destroy
        Project.find(params[:id]).destroy
        redirect_to user_path(session[:current_user]), notice: "Project deleted"
    end 
    # Ensure that all fields are present
    def project_params
        params.require(:project).permit(:name, :description)
    end

    
end
