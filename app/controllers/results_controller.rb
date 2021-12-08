# require_relative '../../lib/smtp'
class ResultsController < ApplicationController
    # Gather and create all fields so a result can be posted
    def new
        @result = Result.new
        @poll = Poll.find(params[:poll_id])
        @project = Project.find(params[:project_id])
        @team = Team.find(params[:team_id])
        @user = User.find(session[:current_user])
    end 

    def is_int(input)
        true if Integer(input) rescue false
    end 

    # This is the code called when a user is filling out the form itself
    def create
        
        @poll_id = params[:poll_id]
        @team_id = params[:team_id]
        @rater_id = User.find(session[:current_user]).id
        @team = Team.find(@team_id)
        # Grade each user that is on your team
        for user in @team.users
            @ratee_score = params[:"score_#{user.id}"]
            @ratee_comment = params[:"comment_#{user.id}"]
            @ratee_id = user.id
            if !is_int(@ratee_score) || @ratee_score.to_i < 0 || @ratee_score.to_i >100
                return redirect_to user_path(session[:current_user]), notice: "You must enter an integer between 0-100 for score!"
            end 
            @result = Result.where(rater_id: @rater_id, ratee_id: @ratee_id, poll_id: @poll_id).first
            # @result.poll_id = @poll_id
            # @result.team_id = @team_id
            # @result.rater_id = @rater_id
            # @result.ratee_id = @ratee_id
            
            # @result.score = @ratee_score
            # @result.comment = @ratee_comment
            # @result.is_complete = true
            if !@result.update(:score => @ratee_score, :comment => @ratee_comment, :is_complete => true)
                render :new, notice: "Something went wrong, please re-enter"
            end

            puts @result.score

            # if @result.save
            #     email = User.find(session[:current_user]).email
            #     puts `\npython3 smtp.py #{email} "1"`
            #     @polling = Polling.where(user_id: session[:current_user], poll_id: @poll_id).first
            #     @polling.update_attribute(:is_complete, true)
            #     return redirect_to user_path(session[:current_user]), notice: "submitted successful"
            # else 
            #     puts "-------------------------"
            #     render :new
            # end

        end
        # Send the email that their form was completed. Then update fields and redirect
        email = User.find(session[:current_user]).email
        puts `\npython3 smtp.py #{email} "1"`
        @polling = Polling.where(user_id: session[:current_user], poll_id: @poll_id).first
        @polling.update_attribute(:is_complete, true)
        return redirect_to user_path(session[:current_user]), notice: "submitted successful"
    end 
end
