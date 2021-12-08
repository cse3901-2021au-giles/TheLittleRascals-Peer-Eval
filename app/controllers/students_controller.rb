class StudentsController < ApplicationController
    # This gathers all possible users
    def index
        @students = Student.all
    end
    # get the current student by finding their id in the db
    def show
        @student = Student.find(params[:id])
    end 

    
end
