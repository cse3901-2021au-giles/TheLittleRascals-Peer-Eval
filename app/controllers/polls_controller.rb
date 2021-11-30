class PollsController < ApplicationController
    def new
        @group_id = params[:group_id]
        @project_id = params[:project_id]
        @poll = Poll.new
    end

    def create
        @poll = Poll.new(poll_params)
        @poll.group_id = params[:group_id]
        @poll.project_id = params[:project_id]
        @time_till_close = params[:time]

        @poll.end_date = Date.today + @time_till_close.to_i

        if @poll.save
            @project = Project.find(params[:project_id])
            @teams = @project.teams
            for team in @teams
                @team_members = team.users
                for team_member in @team_members
                    @polling = Polling.new
                    @polling.poll_id = @poll.id
                    @polling.user_id = team_member.id
                    @polling.is_complete = false
                    @polling.save
                    email = team_member.email
                    exec("python ../lib/smtp.py #{email} 3")

                    for team_mate in @team_members
                        @result = Result.new
                        @result.poll_id = @poll.id
                        @result.rater_id = team_member.id
                        @result.ratee_id = team_mate.id
                        @result.is_complete = false
                        @result.team_id = team.id
                        @result.score = 0
                        @result.comment = "The rater did not leave you a comment"
                        @result.save
                    end 
                end 
            end 
            return redirect_to user_path(session[:current_user]), notice: "New poll created successful"
        else 
            puts "-------------------------"
            render :new
        end 
    end 

    def show_polls
        @project = Project.find(params['project_id'])
        @teams = @project.teams
        @polls = @project.polls
        @group = Group.find(params['group_id'])
        @results_dict = Hash.new
        for poll in @polls
            @team_dict = Hash.new
            for team in @teams 
                @user_dict = Hash.new
                for user in team.users
                    @ave = calculate_ave(poll.id, user.id)
                    @user_dict[user.id] = @ave
                end 
                @team_dict[team.id] = @user_dict
            end 
            @results_dict[poll.id] = @team_dict
        end
        @user = User.find(session[:current_user])
    end 

    def calculate_ave(poll_id, ratee_id)

        @result = Result.where(poll_id: poll_id, ratee_id: ratee_id, is_complete: true)
        @result = @result.average(:score)
        return @result
    end
    def poll_params
        params.require(:poll).permit(:description)
    end
end
