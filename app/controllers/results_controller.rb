# require_relative '../../lib/smtp'
class ResultsController < ApplicationController
    def new
        @result = Result.new
        @poll = Poll.find(params[:poll_id])
        @project = Project.find(params[:project_id])
        @team = Team.find(params[:team_id])
        @user = User.find(session[:current_user])
    end 

    def create
        
        @poll_id = params[:poll_id]
        @team_id = params[:team_id]
        @rater_id = User.find(session[:current_user]).id
        @team = Team.find(@team_id)

        for user in @team.users
            @ratee_score = params[:"score_#{user.id}"]
            @ratee_comment = params[:"comment_#{user.id}"]
            @ratee_id = user.id

            @result = Result.where(rater_id: @rater_id, ratee_id: @ratee_id, poll_id: @poll_id).first
            if !@result.update(:score => @ratee_score, :comment => @ratee_comment, :is_complete => true)
                render :new, notice: "Something went wrong, please re-enter"
            end

            puts @result.score

        end 
        @polling = Polling.where(user_id: session[:current_user], poll_id: @poll_id).first
        @polling.update_attribute(:is_complete, true)
        return redirect_to user_path(session[:current_user]), notice: "submitted successful"
    end 
end
