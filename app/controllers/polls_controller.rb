class PollsController < ApplicationController
    # Prepare the fields so that we can make a new poll
    def new
        @group_id = params[:group_id]
        @project_id = params[:project_id]
        @poll = Poll.new
    end

    def is_int(input)
        true if Integer(input) rescue false
    end 
    # Get all the params and and default to unreleased
    def create
        @poll = Poll.new(poll_params)
        @poll.group_id = params[:group_id]
        @poll.project_id = params[:project_id]
        @time_till_close = params[:time]
        if !is_int(@time_till_close) || @time_till_close.to_i < 0
            return redirect_to user_path(session[:current_user]), notice: "You must enter an positive integer for poll close date!"
        end 

        @poll.is_released = false
        @poll.end_date = Date.today + @time_till_close.to_i
        # If no error is thrown, save all fields, assign members and notify them by email
        if @poll.save
            @project = Project.find(params[:project_id])
            @teams = @project.teams
            @teams.each do |team|
                @team_members = team.users
                @team_members.each do |team_member|
                    @polling = Polling.new
                    @polling.poll_id = @poll.id
                    @polling.user_id = team_member.id
                    @polling.is_complete = false
                    @polling.save
                    # Send the email to notify new assignment
                    email = team_member.email
                    puts `\npython3 smtp.py #{email} "3"`
                    # Fill in the default fields
                    @team_members.each do |team_mate|
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
    # We dont want the general view, but a specific view of one poll
    def show_single_poll
        
        @user = User.find(session[:current_user])
        if @user.admin
            return redirect_to user_path(session[:current_user]), notice: "You do not have the right to view the page"
        end
        # Set all fields to default value
        @project = Project.find(params['project_id'])
        @team = Team.find(Result.where(poll_id: params['poll_id'], rater_id: @user.id).first.team_id)
        @group = Group.find(params['group_id'])
        @poll = Poll.find(params['poll_id'])
        @team_total = 0
        @valid_user_count = 0
        @has_team_total = false
        @curr_user_ave = 0
        @has_curr_user_ave = false
        # Get each user and increment appropriate counts and averages/scores
        @team.users.each do |user|
            @ave = calculate_ave(@poll.id, user.id)
            if @ave
                if user.id == @user.id
                    @curr_user_ave = @ave
                    @has_curr_user_ave = true
                end
                @has_team_total = true
                @team_total += @ave
                @valid_user_count += 1
            end 
        end 
        if @has_team_total
            @team_ave = @team_total/@valid_user_count
        end 

        @comments = Result.where(poll_id: @poll.id, ratee_id: @user.id, is_complete: true)
    end 

    # Merely show the poll, dont update or change anything
    def show_polls
        @project = Project.find(params['project_id'])
        @teams = @project.teams
        @polls = @project.polls
        @group = Group.find(params['group_id'])
        @results_dict = Hash.new
        @polls.each do |poll|
            @team_dict = Hash.new
            @teams.each do |team| 
                @user_dict = Hash.new
                team.users.each do |user|
                    @ave = calculate_ave(poll.id, user.id)
                    @user_dict[user.id] = @ave
                end 
                @team_dict[team.id] = @user_dict
            end 
            @results_dict[poll.id] = @team_dict
        end
        @user = User.find(session[:current_user])
    end 
    # Get the poll by user assignment and then release it.
    def edit 
        @poll = Poll.find(params[:id])
        @poll.update_attribute(:is_released, true)
        return redirect_back(fallback_location: user_path(session[:current_user])), notice: "Poll is released"        
    end 
    # Only calculate if it is complete, then save this computation
    def calculate_ave(poll_id, ratee_id)

        @result = Result.where(poll_id: poll_id, ratee_id: ratee_id, is_complete: true)
        @result = @result.average(:score)
        return @result
    end
    # Ensure all is filled out
    def poll_params
        params.require(:poll).permit(:description)
    end
end
