class TeamsController < ApplicationController
    # Call makes a new group using the parameters specified
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
        # Cant make a team without members. If not 0, they want the cpu to make the teams

        if params[:team_size].length != 0
            # if params[:team_size] !~ /\A\d+\Z/
            #     alert = "Size can only be numerical and within bounds"
            #     redirect_to  create, notice: alert
            # end
            @team_size = params[:team_size]
            @group = Group.find(@group_id)
            @users = @group.users.where.not(admin: true).ids
            @users = @users.shuffle
            @team_splits = @users.each_slice(@team_size.to_i).to_a
            # Gather the correct fields for the db
            @team_splits.length.times do |i|
                @team_members = @team_splits[i]
                @team = Team.new
                @team.name = LiterateRandomizer.word
                @team.description = "Random description for the team"
                @team.group_id = @group_id
                @team.project_id = @project_id
                # If it does save and only then
                if @team.save
                    @project = Project.find(@project_id)
                    @project.update_attribute(:has_team, true)
                    @team_size.to_i.times do |j|
                        @teaming = Teaming.new
                        @teaming.team_id = @team.id
                        @teaming.user_id = @team_members[j]
                        @teaming.save
                    end
                    # Only on the last iteration do this
                    if i == @team_size.to_i-1
                        return redirect_to user_path(session[:current_user]), notice: "New team created successful"
                    end 
                else 
                    render :new
                end 
            end
            # This means they want to manually enter them
        elsif params[:team_members].length != 0
            # Get every member and put them in a list
            @teams = params[:team_members].split("|")
            @i = 0
            for team in @teams
                # Loop through every user and assign them the group with the corresponding fields
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
                    # On the last iteration, and only then redirect
                    if @i == @teams.length
                        return redirect_to user_path(session[:current_user]), notice: "New team created successful"
                    end 
                else 
                    render :new
                end 
            end 
        end
        # If we reach this, an error occurred
        return redirect_to user_path(session[:current_user]), notice: "Something went wrong"

    end 
    # Get the parameters so that we can change the team
    def modify_team
        @team = Team.find(params['team_id'])
        @user = User.find(session[:current_user])
        @group = Group.find(@team.group_id)
        @project = Project.find(params['project_id'])

    end 
    # Display all the teams on te users home page
    def show_teams
        @project = Project.find(params['project_id'])
        @user = User.find(session[:current_user])

    end 

    def update
        @team = Team.find(params[:id])
        @team.update_attribute(:name, team_params['name'])
        @team.update_attribute(:description, team_params['description'])

        return redirect_to user_path(session[:current_user]), notice: "Team modified successfully!"
    end 
    # gather all the team params
    def team_params
        params.require(:team).permit(:name, :description)
    end
end
