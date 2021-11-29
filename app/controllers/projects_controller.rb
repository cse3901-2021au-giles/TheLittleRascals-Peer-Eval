class ProjectsController < ApplicationController
    def new
        @group_id = params[:group_id]
        @project = Project.new
    end

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

    def show
        @project = Project.find(params['project_id'])
        @user = User.find(params['user_id'])
    end 

    def destroy
        Project.find(params[:id]).destroy
        redirect_to user_path(session[:current_user]), notice: "Project deleted"
    end 

    def project_params
        params.require(:project).permit(:name, :description)
    end

    
end
