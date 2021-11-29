class TeamsController < ApplicationController
    def new 
        @group_id = params[:group_id]
        @project_id = params[:project_id]
        @user = User.find(params[:user_id])
        @team = Team.new
    end

    def create
        @group_id = params[:group_id]
        @project_id = params[:project_id]
        @team_size = params[:team_size]
        @group = Group.find(@group_id)
        @users = @group.users.ids
        @users = @users.shuffle
        @team_splits = @users.each_slice(@team_size.to_i).to_a

        @team_splits.length.times do |i|
            @team_members = @team_splits[i]
            @team = Team.new(team_params)
            @team.name = (0...50).map{('a'..'z').to_a[rand(26)]}.join
            @team.description = (0...50).map{('a'..'z').to_a[rand(26)]}.join
            @team.group_id = @group_id
            @team.project_id = @project_id
            if @team.save
                @project = Project.find(@project_id)
                @project.update_attribute(:has_team, true)
                @team_size.to_i.times do |j|
                    @teaming = Teaming.new
                    @teaming.team_id = @team.id
                    @teaming.user_id = @team_members[j]
                    @teaming.save
                end  
                if i == @team_size.to_i-1
                    return redirect_to user_path(session[:current_user]), notice: "New team created successful"
                end 
            else 
                render :new
            end 
        end 
    end 

    def show_teams
        @project = Project.find(params['project_id'])
        @user = User.find(params['user_id'])
    end 


    def team_params
        params.require(:team).permit(:name, :description)
    end
end
