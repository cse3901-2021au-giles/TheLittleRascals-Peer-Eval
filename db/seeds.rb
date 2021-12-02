# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

student_one = {
    :name => "Jike",
    :email => "jike@jike.com"
}

student_two = {
    :name => "Jake",
    :email => "jake@jake.com"
}

user_one = {
    :fname => "temp",
    :lname => "temp",
    :email => "temp",
    :password_digest => "temp",
    :admin => false,
    :created_at => false,
    :updated_at => false,
    :temp_user => false
}

grouping1 = {
    :user_id => 1,
    :group_id => 1,
    :created_at => false,
    :updated_at => false
}

group1 = {
    :name => "group1",
    :size => 1,
    :created_at => false,
    :updated_at => false,
    :owner => 1
}

Student.create(student_one)
Student.create(student_two)
User.create(user_one)

Group.create(group1)
Grouping.create(grouping1)