class TeamsController < ApplicationController
    def new 
        @group_id = params[:group_id]
        @group = Group.find(@group_id )
        @project_id = params[:project_id]
        @project = Project.find(@project_id)
        @user = User.find(session[:current_user])
        @team = Team.new
    end

    def create
        @group_id = params[:group_id]
        @project_id = params[:project_id]
        if params[:team_size].length != 0

            @team_size = params[:team_size]
            @group = Group.find(@group_id)
            @users = @group.users.where.not(admin: true).ids
            @users = @users.shuffle
            @team_splits = @users.each_slice(@team_size.to_i).to_a

            @team_splits.length.times do |i|
                @team_members = @team_splits[i]
                @team = Team.new(team_params)
                @team.name = LiterateRandomizer.word
                @team.description = "Random description for the team"
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
        elsif params[:team_members].length != 0
            @teams = params[:team_members].split("|")
            @i = 0
            for team in @teams

                @new_team = Team.new 
                @new_team.name = LiterateRandomizer.word
                @new_team.description = "Random description for the team"
                @new_team.group_id = @group_id
                @new_team.project_id = @project_id
                if @new_team.save
                    @i = @i+1
                    @project = Project.find(@project_id)
                    @project.update_attribute(:has_team, true)
                    for member in team.split(" ")

                        @teaming = Teaming.new
                        @teaming.team_id = @new_team.id
                        @teaming.user_id = member.to_i
                        @teaming.save
                    end  
                    if @i == @teams.length
                        return redirect_to user_path(session[:current_user]), notice: "New team created successful"
                    end 
                else 
                    render :new
                end 
            end 
        end
        return redirect_to user_path(session[:current_user]), notice: "Something went wrong"

    end 

    def modify_team
        @team = Team.find(params['team_id'])
        @user = User.find(session[:current_user])
        @group = Group.find(@team.group_id)
        @project = Project.find(params['project_id'])

    end 

    def show_teams
        @project = Project.find(params['project_id'])
        @user = User.find(session[:current_user])

    end 

    def update
        @team = Team.find(params[:id])
        # @to_remove = params['user_remove'].split
        # @to_add = params['user_add'].split
        # @project = Project.find(params['project_id'])
        # for remove in @to_remove
        #     if @team.users.ids.include?(remove.to_i)
        #         Teaming.where(user_id: remove.to_i, team_id: @team.id).destroy_all

        #     end 
        # end 
        
        # for add in @to_add
        #     if !@team.users.ids.include?(add.to_i) && !User.find(add.to_i).teams.where(project_id: @project.id).first
        #         @teaming = Teaming.new
        #         @teaming.user_id = add.to_i
        #         @teaming.team_id = @team.id
        #         @teaming.save
        #     end 
        # end 
        @team.update_attribute(:name, team_params['name'])
        @team.update_attribute(:description, team_params['description'])

        return redirect_to user_path(session[:current_user]), notice: "Team modified successfully!"
    end 

    def team_params
        params.require(:team).permit(:name, :description)
    end
end
